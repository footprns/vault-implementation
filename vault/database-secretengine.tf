

resource "vault_database_secret_backend_connection" "database" {
  for_each      = { for backend in local.db-secretsengine : "${backend.backend}:${backend.name}" => backend }
  backend       = each.value.backend
  name          = each.value.name
  allowed_roles = each.value.allowed_roles
  dynamic "postgresql" {
    for_each = each.value.type == "postgresql" ? toset([1]) : toset([0])
    content {
      connection_url = "postgresql://postgres:my-secret-pw@postgres-svc.default.svc.cluster.local:5432/postgres?sslmode=disable"
    }
  }
}


resource "vault_database_secret_backend_role" "role" {
  for_each            = { for backend in local.db-role : "${backend.backend}-${backend.db_name}-${backend.role}" => backend }
  backend             = each.value.backend
  name                = each.key
  db_name             = each.value.db_name
  creation_statements = each.value.creation_statements
}

