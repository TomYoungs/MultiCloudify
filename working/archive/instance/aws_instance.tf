provider "aws" {
  region = var.region # replace with your desired region
}

resource "aws_instance" "example" {
  ami           = var.ami 
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}