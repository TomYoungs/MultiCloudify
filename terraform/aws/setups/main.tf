# visit docs for more information 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

terraform {
  backend "s3" {
    bucket = "infra-tools-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "infra-tools-tf-locks"
    encrypt        = true
  }
}

#Establish what provider is being used, azure/gcp/aws etc.
provider "aws" {
  region = "us-east-2"
}

# refers to a EC2 instance (Virtual Machine) in this example the EC2 is being created from a module in ./instance/aws_instance.tf 
# using modules makes terraform code more reusable and allows you to create and setup different types of EC2's while using the same code
# see variables.tf for value descriptions as well as some configurable defaults
module "basic_ec2" {
  source = "../modules/basic_ec2"
  # AMIs are region spesific so visit the AMI catalog and pick an appropirate option for your region
  ami           = "ami-0568936c8d2b91c4e"
  instance_type = "t2.micro"
}