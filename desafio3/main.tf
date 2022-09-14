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
  region                   = "us-east-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "thalesejlopes"

  default_tags {
    tags = {
      owner       = "Thales Lopes"
      managed-by  = "Thales Lopes"
      description = "Desafio Empresa3"
    }
  }
}