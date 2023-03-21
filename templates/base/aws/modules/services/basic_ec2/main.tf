terraform {
    required_version = ">= 1.3.9"
}

resource "aws_instance" "example" {
  ami           = var.ami 
  instance_type = var.instance_type

  tags = {
    Name = "${var.prefixname}-instance"
  }
}

resource "aws_security_group" "example" {
  name        = "${var.prefixname}-security-group"
  description = "security group for ec2: ${aws_instance.example.tags.Name}"

  ingress {
    from_port   = var.ssh_from_port
    to_port     = var.ssh_to_port
    protocol    = var.ssh_protocol
    cidr_blocks = var.ssh_cidr_blocks
  }

  ingress {
    from_port   = var.http_from_port
    to_port     = var.http_to_port
    protocol    = var.http_protocol
    cidr_blocks = var.http_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
}