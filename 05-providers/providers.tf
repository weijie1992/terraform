terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
  alias  = "sydney"
}


resource "aws_s3_bucket" "weijie_bucket_sydney" {
  bucket   = "weijie-bucket-sydney"
  provider = aws.sydney
}

resource "aws_s3_bucket" "weijie_bucket" {
  bucket = "weijie-bucket"
}
