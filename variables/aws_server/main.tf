terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}
provider "aws" {
  region  = "ap-southeast-2"
}

# locals {
#   ami = "ami-087..."
# }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


variable "instance_type" {
  type = string
  description = "The size of an instance"
  sensitive = true
  validation {
    condition = can(regex("^t2.",var.instance_type))
    error_message = "The instance must be t2."
  }
}

resource "aws_instance" "my_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}
output "instance_ip_addr" {
  value = aws_instance.my_server.public_ip
}
