vault-mounts = [{
  path        = "marketing-kv"
  type        = "kv-v2"
  description = "KV for Marketing"
  policies = [{
    name   = "app1-dev-readonly"
    policy = <<EOT
path "marketing-kv/data/marketing-app1/dev" {
  capabilities = ["read"]
}
EOT
    },
    {
      name   = "app1-dev-readwrite"
      policy = <<EOT
path "marketing-kv/data/marketing-app1/dev" {
  capabilities = ["read","update"]
}
EOT
  }, ]
  },
  {
    path        = "marketing-db"
    type        = "database"
    description = "Database for Marketing"
  },
  {
    path        = "hr-db"
    type        = "database"
    description = "Database for HR"
  },
  {
    path        = "marketing-ssh"
    type        = "ssh"
    description = "SSH access for Marketing"
  },
  {
    path        = "hr-kv"
    type        = "kv-v2"
    description = "KV for HR"
    policies = [{
      name   = "app1-dev-readonly"
      policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
    }]
}]
# DO NOT PUT secret in configuration
kv-secrets = [{
  path      = "marketing-kv/marketing-app1/dev"
  data_json = <<EOT
{
    "delete_this_key": "delete_this_value"
}
EOT
  },
  {
    path      = "marketing-kv/marketing-app1/qa"
    data_json = <<EOT
{
    "delete_this_key": "delete_this_value"
}
EOT
  },
]

auth-backends = [{
  path = "gitlab-jwt"
  type = "jwt"
  },
  {
    path = "marketing-app1-dev-k8s"
    type = "kubernetes"
  },
  {
    path = "marketing-app1-qa-k8s"
    type = "kubernetes"
  },
  {
    path = "gsuite-oidc"
    type = "oidc"
  },
]


db-secretengines = [{
  backend = "marketing-db"
  names = [{
    name = "app1-dev-db"
    type = "postgresql"
    roles = [{
      role                = "readonly"
      creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
      },
      {
        role                = "readwrite"
        creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
    }]
    },
    {
      name = "app1-qa-db"
      type = "postgresql"
      roles = [{
        role                = "readonly"
        creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
        },
        {
          role                = "readwrite"
          creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
      }]
    },
  ]
  },
  {
    backend = "hr-db"
    names = [{
      name = "app1-dev-db"
      type = "postgresql"
      roles = [{
        role                = "read-only"
        creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
        },
        {
          role                = "read-write"
          creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
      }]
    }]
}, ]

