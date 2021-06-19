resource "vault_auth_backend" "auth-backends" {
  for_each = { for auth-backend in var.auth-backends : auth-backend.path => auth-backend }
  path     = each.value.path
  type     = each.value.type

  tune {
    max_lease_ttl = "90000s"
  }
}