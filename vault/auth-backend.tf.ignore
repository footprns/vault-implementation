resource "vault_auth_backend" "auth-backends" {
  for_each = { for auth-backend in var.auth-backends : auth-backend.path => auth-backend if auth-backend.type == "kubernetes" }
  path     = each.value.path
  type     = each.value.type

  tune {
    max_lease_ttl = "90000s"
  }
}

locals {
  auth-jwt-backends = { for item in var.auth-backends : item.path => item if item.type == "jwt" }
  auth-role-backends = flatten([for item in var.auth-backends : [for role in item.roles : {
    backend   = item.path
    role_type = item.type
    role_name = role.role_name
    # token_policies  = role.token_policies
    # token_policies  = [for policy in item.policies[*]["name"] : "${item.path}-${policy}"]
    token_policies  = [for policy in item.policies : "${item.path}-${policy.name}"]
    bound_audiences = role.bound_audiences
    user_claim      = role.user_claim
  }] if item.type == "jwt"])
  auth-policy-backends = flatten([for item in var.auth-backends : [for policy in item.policies : {
    path   = item.path
    name   = policy.name
    policy = policy.policy
  }] if item.type == "jwt"])
}

output "debug" {
  value = local.auth-role-backends
}

resource "vault_jwt_auth_backend" "this" {
  for_each           = { for item in local.auth-jwt-backends : item.path => item }
  description        = "Demonstration of the Terraform JWT auth backend"
  path               = each.value.path
  oidc_discovery_url = each.value.oidc_discovery_url
  bound_issuer       = each.value.bound_issuer
}

resource "vault_policy" "jwt-auth" {
  for_each = { for policy in local.auth-policy-backends : "${policy.path}-${policy.name}" => policy }
  name     = each.key
  policy   = each.value.policy
}

resource "vault_jwt_auth_backend_role" "example" {
  for_each       = { for item in local.auth-role-backends : "${item.backend}-${item.role_name}" => item }
  backend        = each.value.backend
  role_name      = each.value.role_name
  token_policies = each.value.token_policies

  bound_audiences = each.value.bound_audiences
  user_claim      = each.value.user_claim
  role_type       = each.value.role_type
}