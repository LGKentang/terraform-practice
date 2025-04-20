terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "5.92.0"
      }
    }
}

provider "aws" {
  profile = "default"
  region = "ap-southeast-2"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0013d898808600c4a"
  count = 10
  instance_type = "t2.micro"
  tags = {
    Name = "My-Server"
  }
}




