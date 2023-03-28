#!/bin/bash
echo "(export AWS_SECRET_ACCESS_KEY=... | az login)"
echo " "
echo "Have you logged into AWS and/or Azure? (y/N)"
read answer

if [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then
  echo "Proceeding with the script..."
else
  echo "Please perform the necessary tasks before running the script."
  exit 1
fi

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

terraform init -backend-config=backend.hcl
# add state file
terraform apply