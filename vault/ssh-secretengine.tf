locals {
  ssh-secretengines = [for ssh-secretengine in var.vault-mounts : ssh-secretengine if ssh-secretengine.type == "ssh"]
  ssh-role-secretengines = flatten([for ssh-secretengine in var.vault-mounts : [
    for role in ssh-secretengine.roles : {
      backend  = ssh-secretengine.path
      name     = "${ssh-secretengine.path}-${role.name}"
      key_type = role.key_type
    }
  ] if ssh-secretengine.type == "ssh"])
  # ssh-role-secretengines = [ for ssh-secretengine in var.vault-mounts : ssh-secretengine if ssh-secretengine.type == "ssh" ]
}

resource "vault_ssh_secret_backend_ca" "this" {
  for_each             = { for path in local.ssh-secretengines : path.path => path }
  backend              = each.value.path
  generate_signing_key = true
}

resource "vault_ssh_secret_backend_role" "this" {
  for_each                = { for item in local.ssh-role-secretengines : "${item.backend}-${item.name}" => item }
  name                    = each.value.name
  backend                 = each.value.backend
  key_type                = each.value.key_type
  allow_user_certificates = true
  ttl                     = 28800 # 8 hour
  max_ttl                 = 86400 # 24 hours
}