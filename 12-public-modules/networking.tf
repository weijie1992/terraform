data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name            = "12-public-modules"
  cidr            = "10.0.0.0/24"
  private_subnets = ["10.0.0.0/28"]
  public_subnets  = ["10.0.0.16/28"]
  azs             = data.aws_availability_zones.azs.names
}


output "aws_availability_zones" {
  value = data.aws_availability_zones.azs
}
