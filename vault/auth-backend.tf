
resource "vault_auth_backend" "auth-backends" {
  for_each = { for auth-backend in var.auth-backends : auth-backend.path => auth-backend if auth-backend.type == "oidc"}
  path     = each.value.path
  type     = each.value.type

  tune {
    default_lease_ttl = "8h"
    max_lease_ttl     = "24h"
    token_type        = "default-service"
  }
}


resource "vault_jwt_auth_backend" "this" {
  for_each     = { for item in local.auth-jwt-backends : item.path => item }
  description  = "Demonstration of the Terraform JWT auth backend"
  path         = each.value.path
  jwks_url     = each.value.jwks_url
  bound_issuer = each.value.bound_issuer

  tune {
    default_lease_ttl = "8h"
    max_lease_ttl     = "24h"
    token_type        = "default-service"
  }
}

resource "vault_policy" "jwt-auth" {
  for_each = { for policy in local.auth-jwt-policies : "${policy.path}-${policy.name}" => policy }
  name     = each.key
  policy   = each.value.policy
}

resource "vault_jwt_auth_backend_role" "example" {
  for_each       = { for item in local.auth-jwt-roles : "${item.backend}-${item.role_name}" => item }
  backend        = each.value.backend
  role_name      = each.value.role_name
  token_policies = each.value.token_policies

  bound_audiences = each.value.bound_audiences
  bound_claims    = each.value.bound_claims
  user_claim      = each.value.user_claim
  role_type       = each.value.role_type
}