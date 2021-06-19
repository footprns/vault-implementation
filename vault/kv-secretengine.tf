resource "vault_generic_secret" "kv-secrets" {
  for_each  = { for kv-secret in var.kv-secrets : kv-secret.path => kv-secret }
  path      = each.value.path
  data_json = each.value.data_json
}