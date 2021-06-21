

resource "vault_policy" "all" {
  for_each = { for policy in local.secretengine-policy : policy.name => policy }
  name     = each.value.name
  policy   = each.value.policy
}




