terraform {
	/*
  backend "remote" {
    organization = "ExamPro"

    workspaces {
      name = "provisioners"
    }
  }
	*/
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

data "aws_vpc" "main" {
  id = "vpc-087b876b55cfaba9d"
}


resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "MyServer Security Group"
  vpc_id      = data.aws_vpc.main.id

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
			prefix_list_ids  = []
			security_groups = []
			self = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
			prefix_list_ids  = []
			security_groups = []
			self = false
    }
  ]

  egress = [
    {
			description = "outgoing traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
			prefix_list_ids  = []
			security_groups = []
			self = false
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG+wsaIuolFdwQIuznSw4SAC1Uj9XYM829zDG/ThRWQ8bYtV15JSqIIhfA7EHMBhVlrbirZ7AU+969vRzn8GxmCgb8aOFjX5Ce3cZPym62Iaga9WmevTGnz6pAG2AiMRwn7sXTgXmxq7HvaVwvYwn9XGGM78ShlBTqVqemAPtmLdy8kWJJExmC2+LRUappvJ/IT/SzPkA3AZpf2yzh5iO9TXkdBll9GI5VAhaUCyrYyJ8nJkL0+N3HT48ND74/uZGe/ItnK1a8w5EuzG2lQ3eGXKYi9TEYhBKxVrWR6am/bSiTDpmUbduAHljVFGykYe4gfCOM4WAsqWEJW8VjDm6nTaYSY4Pjrs4SIFBsQPTTiO/ECySZScj/a2iMvTPUwSdDFUjo3exPoe0gJ0SJ9mAHX9oOEvvZpP4PrzZ58BDpw6L8As1osfS4AAa8V0qJuArbGirVAvnpmVVOtiCtHw8Hq+hStnGt01mMZZdmZoKirEN7bPjeNSJv0jdc0gKoIioQ5reioTSN9OTS/rY7vJsxf6DugpFwWaQ5j+qjDty2WGPloolqE90qxgvJCjNF2JyTK6e6WS2LjVCAydHAn0MHHn/tNxkP4hdh3zsGYjFU4whkddiA8w4ameagIBbZBGMnACwXrn++f8jbVrxy/otHCNC8z8dYxnjpY/94VQTyNw== darre@LGK"
}

data "template_file" "user_data" {
	template = file("./userdata.yaml")
}


resource "aws_instance" "my_server" {
  ami           = "ami-0013d898808600c4a"
  instance_type = "t2.micro"
	key_name = "${aws_key_pair.deployer.key_name}"
	vpc_security_group_ids = [aws_security_group.sg_my_server.id]
	user_data = data.template_file.user_data.rendered
  provisioner "file" {
    content     = "mars"
    destination = "/home/ec2-user/barsoon.txt"
		connection {
			type     = "ssh"
			user     = "ec2-user"
			host     = "${self.public_ip}"
			private_key = "${file("C:/Users/darre/.ssh/terraform/terraform-provisioners")}"
		}
  }

  tags = {
    Name = "MyServer"
  }
}

output "public_ip"{
	value = aws_instance.my_server.public_ip
  sensitive = true
}