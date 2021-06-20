locals {
  kv-policies = flatten([for kv in var.vault-mounts : [
    for policy in kv.policies : {
      name   = "${kv.path}-${policy.name}"
      policy = policy.policy
    }] if kv.type == "kv-v2"
  ])
}

resource "vault_policy" "all" {
  for_each = { for policy in local.kv-policies : policy.name => policy }
  name     = each.value.name
  policy   = each.value.policy
}




