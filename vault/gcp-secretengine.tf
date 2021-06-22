# run manually 
# vault write it-gcp/config credentials=@imank-vault-ff41205a1944.json

resource "vault_gcp_secret_roleset" "roleset" {
  for_each     = { for item in local.gcp-role-secretengines : item.backend => item }
  backend      = each.value.backend
  roleset      = each.value.roleset
  secret_type  = each.value.secret_type
  project      = each.value.project
  token_scopes = each.value.token_scopes

  #   binding {
  #     resource = "//cloudresourcemanager.googleapis.com/projects/${each.value.project}"

  #     roles = [
  #       "roles/viewer",
  #     ]
  #   }
  dynamic "binding" {
    for_each = each.value.binding
    content {
      resource = each.value.binding["resource"]
      roles    = each.value.binding["roles"]
    }
  }
}