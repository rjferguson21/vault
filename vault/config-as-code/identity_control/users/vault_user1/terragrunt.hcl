# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../terraform-modules/user"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency userpass_auth_backend {
  config_path = "../../userpass_auth_backend"
  mock_outputs = {
    path = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  auth_backend              = dependency.userpass_auth_backend.outputs.accessor
  identity_entity_name      = "test.user1"
  identity_entity_policies  = ["change-userpass-password"]
  userpass_username         = "user1"
}
