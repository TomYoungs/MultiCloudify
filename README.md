# MultiCloudify
A tool for creating a multi-cloud kick off platform.

## Installation
To install Multicloudify first clone the repo:

` git clone https://github.com/TomYoungs/MultiCloudify.git `

Next you can install the tool dependancies:

` pip install -r requirements.txt `

## Running MultiCloudify

to run MultiCloudify run:

` python3 selector.py `

This will run through the setup steps, choosing providers and some starter resources.

## Terraform State

After the creation of the platform you can procced to the setup state stage, this step is optional, if selected will setup this in a AWS S3 bucket, if you want to use a tool like Terraform Cloud choose no.

### Usage/Limitations

to use hosted state make sure the S3 bucket is deployed and initialised

```terraform
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

## removing state deployment
due to state being tangled up with the deployment of the S3 bucket a certain order needs to be made to remove:
1. go to state tf code and remove the backend config block
2. run tf init to migrate state back to local
3. then run tf destroy to remove the bucket

_Note: if this is done in a incorrect order you may need to manually remove the bucket and the state of other tf files_
