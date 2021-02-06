# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  # Gabe development
  #source = "/Users/gabe/Workspace/terraform-modules/vault/intermediate_ca_cert"
  # Cam development
  // source = "/Users/cameron.banowsky/infrastructure/dev/repo1/cnap/terraform-modules/vault//pki_secret_backend_root_sign_intermediate"
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/pki_secret_backend_root_sign_intermediate?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency mount {
  config_path = "../mount"
  mock_outputs = {
    path = "abc-123"
  }
}

dependency root_mount {
  config_path = "../../../p1_int/mount"
  mock_outputs = {
    path = "abc-123"
  }
}

dependency csr {
  config_path = "../csr"
  mock_outputs = {
    csr = "-----BEGIN CERTIFICATE REQUEST-----"
  }
}

inputs = {
  sub_ca_csr_cn = "dso.mil"
  int_mount_path = dependency.root_mount.outputs.path
  mount_path = dependency.mount.outputs.path
  csr = dependency.csr.outputs.csr
}
