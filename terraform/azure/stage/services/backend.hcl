# backend.hcl
bucket = "infra-tools-terraform-state"
region = "us-east-2"
dynamodb_table = "infra-tools-tf-locks"
encrypt        = true