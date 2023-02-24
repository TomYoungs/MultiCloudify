provider "aws" {
    region        = "us-east-2"
}

# ami is region spesific
# you can built a lookup so it works for multiple regions :)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "example" {
    ami           = "ami-0cc87e5027adcdca8"
    instance_type = "t2.micro" 

    tags = {
        Name = "Terraform Example"
    }
}