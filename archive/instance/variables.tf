variable "region" {
  description = "The AWS region to use."
  default = "us-west-2"
}

variable "ami" {
  description = "The ID of the AMI to use for the instance. visit the aws AMI catalog for more image options"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch. e.g. t2.micro"
}

variable "instance_name" {
  description = "The name of the EC2 instance."
  default = "MultiCloudify example EC2"
}
