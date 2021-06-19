resource "vault_mount" "secretengine" {
  for_each                  = { for vault-mount in var.vault-mounts : vault-mount.path => vault-mount }
  path                      = each.value.path
  type                      = each.value.type
  description               = each.value.description
  default_lease_ttl_seconds = 28800 # 8 hour
  max_lease_ttl_seconds     = 86400 # 24 hours
}
