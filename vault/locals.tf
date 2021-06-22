locals {
  secretengine-policy = flatten([for secretengine in var.secret-engines : [
    for policy in secretengine.policies : {
      name   = "${secretengine.path}-${policy.name}"
      policy = policy.policy
    }] if secretengine.type == "kv-v2"
  ])
  db-secretsengine = flatten([for backend in var.secret-engines : [
    for db in backend.dbs : {
      backend = backend.path
      name    = db.name
      #   allowed_roles = [for role in db.roles[*]["role"] : "${backend.path}-${db.name}-${role}"]
      allowed_roles = [for role in db.roles : "${backend.path}-${db.name}-${role.role}"]
      # allowed_roles = db.roles
      type = db.type
    }
  ] if backend.type == "database"])
  db-role = flatten([for backend in var.secret-engines : [
    for db in backend.dbs : [for role in db.roles : {
      backend             = backend.path
      db_name             = db.name
      type                = db.type
      role                = role.role
      creation_statements = role.creation_statements
    }]

  ] if backend.type == "database"])
  ssh-secretengines = [for ssh-secretengine in var.secret-engines : ssh-secretengine if ssh-secretengine.type == "ssh"]
  ssh-role-secretengines = flatten([for ssh-secretengine in var.secret-engines : [
    for role in ssh-secretengine.roles : {
      backend  = ssh-secretengine.path
      name     = "${ssh-secretengine.path}-${role.name}"
      key_type = role.key_type
    }
  ] if ssh-secretengine.type == "ssh"])
  gcp-role-secretengines = flatten([for ssh-secretengine in var.secret-engines : [
    for role in ssh-secretengine.roles : {
      backend      = ssh-secretengine.path
      roleset      = "${ssh-secretengine.path}-${role.roleset}"
      secret_type  = role.secret_type
      project      = role.project
      token_scopes = role.token_scopes
      binding      = role.binding
    }
  ] if ssh-secretengine.type == "gcp"])

  auth-jwt-backends = { for item in var.auth-backends : item.path => item if item.type == "jwt" }
  auth-jwt-policies = flatten([for item in var.auth-backends : [for policy in item.policies : {
    path   = item.path
    name   = policy.name
    policy = policy.policy
  }] if item.type == "jwt"])
  auth-jwt-roles = flatten([for item in var.auth-backends : [for role in item.roles : {
    backend         = item.path
    role_type       = item.type
    role_name       = role.role_name
    token_policies  = [for policy in item.policies : "${item.path}-${policy.name}"]
    bound_audiences = role.bound_audiences
    user_claim      = role.user_claim
    bound_claims    = role.bound_claims
  }] if item.type == "jwt"])
}