provider "aws" {
  region = "us-west-2" # replace with your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # replace with your desired AMI
  instance_type = "t2.micro" # replace with your desired instance type

  tags = {
    Name = "example-instance"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}