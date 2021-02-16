# dso.mil ca wip
# mount point for dso.mil intermediate ca
resource "vault_mount" "pki_dso_p1_int" {
  path                  = "pki/dso/p1_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
  seal_wrap                = true
  external_entropy_access  = true
}

# generate p1 dso csr
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_dso_p1_int" {
  backend = vault_mount.pki_dso_p1_int.path

  type        = "internal"
  common_name = "DoD P1 DSO Intermediate CA"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  organization = "U.S. Government"
  ou           = "DoD PKI"
}

# sign dso csr with p1 int ca
resource "vault_pki_secret_backend_root_sign_intermediate" "pki_dso_p1_int" {
  backend = vault_mount.pki_p1_int.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.pki_dso_p1_int.csr
  common_name          = "DoD P1 DSO Intermediate CA"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}

# store signed dso p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "pki_dso_p1_int" {
  backend = vault_mount.pki_dso_p1_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_dso_p1_int.certificate
}

# create role
resource "vault_pki_secret_backend_role" "pki_dso_p1_int_leaf" {
  backend            = vault_mount.pki_dso_p1_int.path
  name               = "dso-p1-leaf-cert" # name of role
  allowed_domains    = ["dso.mil"] 
  allow_subdomains   = true
  allow_bare_domains = false
  allow_glob_domains = false
  enforce_hostnames  = true
  allow_any_name     = false
  allow_ip_sans      = false
  server_flag        = true
  client_flag        = true

  key_usage          = [
      "DigitalSignature",
      "KeyAgreement",
      "KeyEncipherment",
  ]
  max_ttl            = "94608000" # 3 years
  ttl                = "94608000" # 3 years
}
