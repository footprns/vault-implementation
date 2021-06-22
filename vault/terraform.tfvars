secret-engines = [
  {
    path        = "marketing-kv"
    type        = "kv-v2"
    description = "KV for Marketing"
    policies = [{
      name   = "app1-dev"
      policy = <<EOT
path "marketing-kv/data/marketing-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
      {
        name   = "app1-prod"
        policy = <<EOT
path "marketing-kv/data/marketing-app1/prod" {
  capabilities = ["read","update"]
}
EOT
    }, ]
  },
  {
    path        = "marketing-db"
    type        = "database"
    description = "Database for Marketing"
    dbs = [{
      name = "app1-dev-db"
      type = "postgresql"
      roles = [{
        role                = "update-record"
        creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
        },
        {
          role                = "read-record"
          creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
      }]
      },
      {
        name = "app1-prod-db"
        type = "postgresql"
        roles = [{
          role                = "update-record"
          creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
          },
          {
            role                = "read-record"
            creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
        }]
      },
    ]
  },
  {
    path        = "it-kv"
    type        = "kv-v2"
    description = "KV for IT"
    policies = [{
      name   = "app1-dev"
      policy = <<EOT
path "it-kv/data/it-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
      {
        name   = "app1-prod"
        policy = <<EOT
path "it-kv/data/it-app1/prod" {
  capabilities = ["read","update"]
}
EOT
    }, ]
  },
  {
    path        = "it-ssh"
    type        = "ssh"
    description = "SSH access for Marketing"
    roles = [{
      name     = "infraadmin"
      key_type = "ca"
      },
      {
        name     = "devadmin"
        key_type = "ca"
    }, ]
  },
  {
    path        = "it-gcp"
    type        = "gcp"
    description = "GCP access for IT"
    roles = [{
      roleset      = "project_viewer"
      secret_type  = "service_account_key"
      project      = "imank-vault"
      token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
      binding = {
        resource = "//cloudresourcemanager.googleapis.com/projects/imank-vault"
        roles = [
          "roles/viewer",
        ]
      }

    }]
  }
]

auth-backends = [{
  path = "google-oidc"
  type = "oidc"
  # further configuration is from UI
  },
  {
    path         = "gitlab-jwt"
    type         = "jwt"
    jwks_url     = "https://gitlab.com/-/jwks"
    bound_issuer = "gitlab.com"
    tune = {
      max_lease_ttl = "90000s"
    }
    roles = [{
      role_name = "deploy-app"
      # token_policies  = ["default", "dev", "prod"] # policy take from below block
      bound_audiences = ["https://myco.test"]
      user_claim      = "user_email"
      bound_claims = {
        project_id = "26398385"
        ref        = "master"
        ref_type   = "branch"
      }
    }]
    policies = [{
      name   = "deployer"
      policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
      {
        name   = "tester"
        policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
    ]
  },

]