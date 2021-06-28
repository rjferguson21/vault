# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../terraform-modules/audit"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  type        =  "file"
  path        =  "stdout"
  description =  "sends audit logs to stdout to be picked up by fluentbit"
  local       =  false
  options     =  {
    file_path = "stdout"
  }
}