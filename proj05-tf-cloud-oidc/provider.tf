terraform {
  required_version = "~> 1.9"

  cloud {
    organization = "weijie-test"
    workspaces {
      name = "terraform-cli"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
