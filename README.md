# MultiCloudify
A tool for creating multi-cloud platforms


# Terraform State

## Usage/Limitations
to use hosted state make sure the S3 bucket is deployed and initialized
```json
terraform {
  backend "s3" {
    bucket = "infra-tools-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "infra-tools-tf-locks"
    encrypt        = true
  }
}
```

## removing state file
due to state being tangled up with the deployment of the S3 bucket a certain order needs to be made to remove:
1. go to state tf code and remove the backend config block
2. run tf init to migrate state back to local
3. then run tf destroy to remove the bucket

_Note: if this is done in a incorrect order you may need to manually remove the bucket and the state of other tf files_