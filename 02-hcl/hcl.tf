terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

resource "aws_s3_bucket" "weijie-bucket" {
  bucket = var.weijie_bucket_name
}

data "aws_s3_bucket" "weijie-external-bucket" {
  bucket = "weijie-bucket-not-managed-by-me"
}

variable "weijie_bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "weijie-default-bucket-name"
}

output "weijie_bucket_id" {
  value = aws_s3_bucket.weijie-bucket.id
}

locals {
  local_example = "This is a local variable"
}

module "weijie_module" {
  source = "./weijie-module-example"
}
