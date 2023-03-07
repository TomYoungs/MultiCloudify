# visit docs for more information 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

#Establish what provider is being used, azure/gcp/aws etc.
provider "aws" {
  region = "us-east-2"
}

# refers to a EC2 instance (Virtual Machine) in this example the EC2 is being created from a module in ./instance/aws_instance.tf 
# using modules makes terraform code more reusable and allows you to create and setup different types of EC2's while using the same code
# see variables.tf for value descriptions as well as some configurable defaults
module "instance" {
  source = "./instance"
  # AMIs are region spesific so visit the AMI catalog and pick an appropirate option for your region
  ami = "ami-0cc87e5027adcdca8"
  instance_type = "t2.micro"
}

# A necessary component of a EC2, this essentially is a virtual firewall that managed inbound and outbound traffic for a EC2
# in the version below all the defaults are being used so there is no need to reference them here 
# see ./security_group/variables.tf for details
module "security_group" {
  source = "./security_group"
  name = "example-security-group"
  description = "Example security group"
}

