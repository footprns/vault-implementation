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
  path               = "gitlab-jwt"
  type               = "jwt"
  oidc_discovery_url = "https://myco.auth0.com/"
  bound_issuer       = "https://myco.auth0.com/"
  roles = [{
    role_name       = "test-role"
    token_policies  = ["default", "dev", "prod"]
    bound_audiences = ["https://myco.test"]
    user_claim      = "https://vault/user"
  }]
  policies = [{
    name   = "gitlab-jwt-pol"
    policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
    },
    {
      name   = "gitlab-jwt02-pol"
      policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
    },
  ]
  },
  {
    path               = "gitlab-jwt02"
    type               = "jwt"
    oidc_discovery_url = "https://myco.auth0.com/"
    bound_issuer       = "https://myco.auth0.com/"
    roles = [{
      role_name       = "test-role"
      token_policies  = ["default", "dev", "prod"]
      bound_audiences = ["https://myco.test"]
      user_claim      = "https://vault/user"
    }]
    policies = [{
      name   = "gitlab-jwt-pol"
      policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
      {
        name   = "gitlab-jwt02-pol"
        policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
    ]
  },
  {
    path                   = "marketing-app1-dev-k8s"
    type                   = "kubernetes"
    kubernetes_host        = "https://kubernetes.docker.internal:6443"
    kubernetes_ca_cert     = "-----BEGIN CERTIFICATE----- MIIC5zCCAc+gAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl cm5ldGVzMB4XDTIxMDUwNDE0MzQ0MloXDTMxMDUwMjE0MzQ0MlowFTETMBEGA1UE AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANgt 1A4+1yQ+pLGMhw3uPVzW3+7NN530IPw6XDSvJ1u/nQnq7NXsuAm4pn71e00scob1 bDNkKC2brXprhrX+V9+2e91DfQjESeF9n52HDjwhy1iXmvrpjVK74r85k/u67HJa RyKPMTnOeL+5JUMVYsQrWwVhxU6ENTo4JmOgUrqcwrNY/b+o/KIfpqH+KqddpHCz a8/fXJzym2MniYzGkHW3XkJ3L1Tv8Fh7wEmNUqn8jDHfi1VDzmyQ4Cgt7wR9t8ox 5co797yHStljUpWdJwK+WH3LzksqRYd37C1WG7HzX9rGr4yqtciOOPQkt22ZcEGP oM0B9c3NpYN5yqaUmmsCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB /wQFMAMBAf8wHQYDVR0OBBYEFOUho/3SmV/RJHNQOKW6FZqFYB8xMA0GCSqGSIb3 DQEBCwUAA4IBAQAOj16TdA30pgrzbP4AnX883tlkqeJWBX79YnEoSbphMig7d8ws OFIe0ZQ2lhADuWeIXEoZXJ3VUH2OR2KcfGx1dL9cljM1OcK2dBAAqlgA+yWg+kaq EQq2/DLSGihjvWilPTOptfrt0OcErSuQx1tlxhExPdhK2B3DM7GSooGgI9MfsMtW aull2DkNotKSM/CXGPjEMUu30yVtNX7lz20FA92uaQBPBJI1DL0PJwsWXTl8gGZJ UXYPP0Ib07zEISjRrqD0O83wRJDBAYneIXcQSZwZFy6d5iBFJDGO2DneL7Gb4GrI B3pqEx1DFqPUYM/anCdZyU1dyrXnn9UdVbpF -----END CERTIFICATE-----"
    token_reviewer_jwt     = "eyJhbGciOiJSUzI1NiIsImtpZCI6Il9La3JuUE9xeVdiSVZkbFRoT29nWFdQRXhxcjdQQlNtZmhqYjJ6STVIMkUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InZhdWx0LWF1dGgtdG9rZW4tNTJnZmoiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoidmF1bHQtYXV0aCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjUzN2VmNjA3LTM0MjctNDkwZC05NzkwLTdmNWVmZTQ3Y2ExZiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OnZhdWx0LWF1dGgifQ.IzSO6zvu3ZywFH2gLVKif0El9I9HRUR_GzwIGR29pD1am8jgI63449W6lnR-9gDnyjkEXkoYwV2kKElWcIRTxOnrnndAKrg_LNTGR4LrU2ibET0lvM0n3T5Z8Mjr7EOavtOvPwmbQFe0OOQhCsX27ktqJFdXi8FOEH3DOM2DNu9DNcwcJGLIJfSda3A48yboqOCpLNhjetRQnyoE75p81tlHy8ALa1D8ebUbv9CvlGsQppzw3chmKrXD8uUkkRmHKLF7McjDXRzgaOCWA1vMkUe1DcNl3wyxWIc59WdPsWOuq6weYDdoOlzUHXwyBM243ObyPy2bz1YbN_OITsaI5Q"
    issuer                 = "api"
    disable_iss_validation = "true"
    roles = [{
      role_name                        = "example-role"
      bound_service_account_names      = ["example"]
      bound_service_account_namespaces = ["example"]
      token_ttl                        = 3600
      token_policies                   = ["default", "dev", "prod"]
      audience                         = "vault"
    }]
    policies = [{
      name   = "k8s-pol"
      policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
      {
        name   = "k8s02-pol"
        policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
    ]
  },
  {
    path                   = "marketing-app1-qa-k8s"
    type                   = "kubernetes"
    kubernetes_host        = "https://kubernetes.docker.internal:6443"
    kubernetes_ca_cert     = "-----BEGIN CERTIFICATE----- MIIC5zCCAc+gAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl cm5ldGVzMB4XDTIxMDUwNDE0MzQ0MloXDTMxMDUwMjE0MzQ0MlowFTETMBEGA1UE AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANgt 1A4+1yQ+pLGMhw3uPVzW3+7NN530IPw6XDSvJ1u/nQnq7NXsuAm4pn71e00scob1 bDNkKC2brXprhrX+V9+2e91DfQjESeF9n52HDjwhy1iXmvrpjVK74r85k/u67HJa RyKPMTnOeL+5JUMVYsQrWwVhxU6ENTo4JmOgUrqcwrNY/b+o/KIfpqH+KqddpHCz a8/fXJzym2MniYzGkHW3XkJ3L1Tv8Fh7wEmNUqn8jDHfi1VDzmyQ4Cgt7wR9t8ox 5co797yHStljUpWdJwK+WH3LzksqRYd37C1WG7HzX9rGr4yqtciOOPQkt22ZcEGP oM0B9c3NpYN5yqaUmmsCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB /wQFMAMBAf8wHQYDVR0OBBYEFOUho/3SmV/RJHNQOKW6FZqFYB8xMA0GCSqGSIb3 DQEBCwUAA4IBAQAOj16TdA30pgrzbP4AnX883tlkqeJWBX79YnEoSbphMig7d8ws OFIe0ZQ2lhADuWeIXEoZXJ3VUH2OR2KcfGx1dL9cljM1OcK2dBAAqlgA+yWg+kaq EQq2/DLSGihjvWilPTOptfrt0OcErSuQx1tlxhExPdhK2B3DM7GSooGgI9MfsMtW aull2DkNotKSM/CXGPjEMUu30yVtNX7lz20FA92uaQBPBJI1DL0PJwsWXTl8gGZJ UXYPP0Ib07zEISjRrqD0O83wRJDBAYneIXcQSZwZFy6d5iBFJDGO2DneL7Gb4GrI B3pqEx1DFqPUYM/anCdZyU1dyrXnn9UdVbpF -----END CERTIFICATE-----"
    token_reviewer_jwt     = "eyJhbGciOiJSUzI1NiIsImtpZCI6Il9La3JuUE9xeVdiSVZkbFRoT29nWFdQRXhxcjdQQlNtZmhqYjJ6STVIMkUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InZhdWx0LWF1dGgtdG9rZW4tNTJnZmoiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoidmF1bHQtYXV0aCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjUzN2VmNjA3LTM0MjctNDkwZC05NzkwLTdmNWVmZTQ3Y2ExZiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OnZhdWx0LWF1dGgifQ.IzSO6zvu3ZywFH2gLVKif0El9I9HRUR_GzwIGR29pD1am8jgI63449W6lnR-9gDnyjkEXkoYwV2kKElWcIRTxOnrnndAKrg_LNTGR4LrU2ibET0lvM0n3T5Z8Mjr7EOavtOvPwmbQFe0OOQhCsX27ktqJFdXi8FOEH3DOM2DNu9DNcwcJGLIJfSda3A48yboqOCpLNhjetRQnyoE75p81tlHy8ALa1D8ebUbv9CvlGsQppzw3chmKrXD8uUkkRmHKLF7McjDXRzgaOCWA1vMkUe1DcNl3wyxWIc59WdPsWOuq6weYDdoOlzUHXwyBM243ObyPy2bz1YbN_OITsaI5Q"
    issuer                 = "api"
    disable_iss_validation = "true"
    roles = [{
      role_name                        = "example-role"
      bound_service_account_names      = ["example"]
      bound_service_account_namespaces = ["example"]
      token_ttl                        = 3600
      token_policies                   = ["default", "dev", "prod"]
      audience                         = "vault"
    }]
    policies = [{
      name   = "k8s-pol"
      policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
      {
        name   = "k8s02-pol"
        policy = <<EOT
path "hr-kv/data/hr-app1/dev" {
  capabilities = ["read"]
}
EOT
      },
    ]
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

