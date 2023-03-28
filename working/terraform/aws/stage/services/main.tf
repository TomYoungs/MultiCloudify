# visit docs for more information 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

terraform {
  # use tf init -backend-config=backend.hcl to get all parameters
  backend "s3" {
    key = "aws/stage/services/terraform.tfstate"
  }
}

#Establish what provider is being used, azure/gcp/aws etc.
provider "aws" {
  region = "us-east-2"
}

# refers to a EC2 instance (Virtual Machine) in this example the EC2 is being created from a module in ./instance/aws_instance.tf 
# using modules makes terraform code more reusable and allows you to create and setup different types of EC2's while using the same code
# see variables.tf for value descriptions as well as some configurable defaults
# module "basic_ec2" {
#   source = "../../modules/services/basic_ec2"
#   # AMIs are region spesific so visit the AMI catalog and pick an appropirate option for your region
#   ami           = "ami-0568936c8d2b91c4e"
#   instance_type = "t2.micro"
# }

# module "cluster_ec2" {
#   source        = "../../modules/services/webserver-cluster"
#   ami           = "ami-0568936c8d2b91c4e"
#   instance_type = "t2.micro"
# }

module "static_website_s3" {
  source = "../../modules/services/static-website-s3-bucket"
}