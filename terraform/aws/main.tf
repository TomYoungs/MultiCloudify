provider "aws" {
  region = "us-west-2" # replace with your desired region
}

module "instance" {
  source = "./instance"
  ami = "ami-0c55b159cbfafe1f0" # replace with your desired AMI
  instance_type = "t2.micro" # replace with your desired instance type
}

module "security_group" {
  source = "./security_group"
  name = "example-sg"
  description = "Example security group"
  inbound_rules = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
