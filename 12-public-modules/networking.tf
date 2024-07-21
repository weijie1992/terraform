locals {
  vpc_cidr             = "10.0.0.0/24"
  private_subnet_cidrs = ["10.0.0.0/28"]
  public_subnet_cidrs  = ["10.0.0.16/28"]
}

data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name            = local.project_name
  cidr            = local.vpc_cidr
  private_subnets = local.private_subnet_cidrs
  public_subnets  = local.public_subnet_cidrs
  azs             = data.aws_availability_zones.azs.names

  tags = local.common_tags
}


output "aws_availability_zones" {
  value = data.aws_availability_zones.azs
}
