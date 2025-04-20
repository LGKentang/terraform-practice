terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "lgk"

    workspaces {
      name = "terraform-getting-started"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

locals {
  project_name = "Darren"
}

