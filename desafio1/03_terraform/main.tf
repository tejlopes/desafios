terraform {
  required_version = ">= 1.0.0"

  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    aws = {
      version = ">= 3.74"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {

  default_tags {
    tags = {
      owner       = "Thales Lopes"
      managed-by  = "Thales Lopes"
      description = "Desafio"
    }
  }
}