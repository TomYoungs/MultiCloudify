# terraform {
#   #parametes are omitted to the backend.hcl therefore when initializing add flag; tf init -backend-config=backend.hcl
#   backend "s3" {
#     key = "global/s3/terraform.tfstate"
#   }
# }

provider "aws" {
  region = "us-east-2"
}

#NOTE this state code is difficult to delete in order to remove this code you need to
#1. remove the backend config and run tf init -migrate-state
#2. comment out the lifecycle prevent destroy, this prevents the tf destroy command
#3. run tf apply to remove lifecycle
#3. then run tf destroy 

resource "aws_s3_bucket" "terraform-state" {
  bucket = "${var.prefixname}-terraform-state"

  # lifecycle {
  #   prevent_destroy = true
  # }
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "${var.prefixname}-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform-state.arn
  description = "The arn of the s3 bucket"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_locks.name
    description = "name of dynamodb table"
}