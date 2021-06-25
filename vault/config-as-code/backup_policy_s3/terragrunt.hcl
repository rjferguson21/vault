# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/generic_endpoint"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  path        = "sys/storage/raft/snapshot-auto/config/s3"
  data_json = <<EOF
{
  "interval": "12h",
  "retain": 2190,
  "storage_type": "aws-s3",
  "aws_s3_region": "us-gov-west-1",
  "aws_s3_bucket": "your-bucket-here"
}
EOF
}