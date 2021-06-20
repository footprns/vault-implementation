locals {
  k8s-config = [for cluster in var.auth-backends : {
    backend                = cluster.path
    kubernetes_host        = cluster.kubernetes_host
    kubernetes_ca_cert     = cluster.kubernetes_ca_cert
    token_reviewer_jwt     = cluster.token_reviewer_jwt
    issuer                 = cluster.issuer
    disable_iss_validation = cluster.disable_iss_validation
  } if cluster.type == "kubernetes"]
  k8s-role = flatten([for cluster in var.auth-backends : [
    for role in cluster.roles : {
      backend                          = cluster.path
      role_name                        = role.role_name
      bound_service_account_names      = role.bound_service_account_names
      bound_service_account_namespaces = role.bound_service_account_namespaces
      token_ttl                        = role.token_ttl
      #   token_policies                   = role.token_policies
      token_policies = [for policy in cluster.roles : "${cluster.path}-${policy.role_name}"]
      audience       = role.audience
    }
  ] if cluster.type == "kubernetes"])
  auth-k8s-policy-backends = flatten([for item in var.auth-backends : [for policy in item.policies : {
    path   = item.path
    name   = policy.name
    policy = policy.policy
  }] if item.type == "kubernetes"])
}




output "debug04" {
  value = local.k8s-role
}

resource "vault_kubernetes_auth_backend_config" "this" {
  for_each               = { for item in local.k8s-config : item.backend => item }
  backend                = each.value.backend
  kubernetes_host        = each.value.kubernetes_host
  kubernetes_ca_cert     = each.value.kubernetes_ca_cert
  token_reviewer_jwt     = each.value.token_reviewer_jwt
  issuer                 = each.value.issuer
  disable_iss_validation = each.value.disable_iss_validation
}

resource "vault_kubernetes_auth_backend_role" "example" {
  for_each                         = { for item in local.k8s-role : item.backend => item }
  backend                          = each.value.backend
  role_name                        = each.value.role_name
  bound_service_account_names      = each.value.bound_service_account_names
  bound_service_account_namespaces = each.value.bound_service_account_namespaces
  token_ttl                        = each.value.token_ttl
  token_policies                   = each.value.token_policies
  audience                         = each.value.audience
}

resource "vault_policy" "k8s-auth" {
  for_each = { for policy in local.auth-k8s-policy-backends : "${policy.path}-${policy.name}" => policy }
  name     = each.key
  policy   = each.value.policy
}