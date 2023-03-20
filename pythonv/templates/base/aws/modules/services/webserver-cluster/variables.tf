variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "ami" {
  description = "The ID of the AMI to use for the instance. visit the aws AMI catalog for more image options"
}

variable "prefixname" {
  description = "prefix for name e.g. *prefixname*-security-group"
  default     = "mcloudifyexample"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch. e.g. t2.micro"
}