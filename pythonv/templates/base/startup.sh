#!/bin/bash

# check if terraform is installed
if ! command -v terraform &> /dev/null
then
    echo "terraform could not be found please install"
    exit
fi

# initialized the state by creating the S3 bucket 
cd aws/global/s3
terraform init
terraform apply

# add reference to tf state and initialize it
echo "
terraform {
  #parametes are omitted to the backend.hcl therefore when initializing add flag; tf init -backend-config=backend.hcl
  backend "s3" {
    key = "global/s3/terraform.tfstate"
  }
}" >> main.tf

tf init -backend-config=backend.hcl
# add state file
tf apply