locals {
  project = "11-multiple-resources"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

resource "aws_vpc" "main2" {
  cidr_block = "100.0.0.0/16"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main2.id
  cidr_block = "100.0.1.0/24"

  lifecycle {
    postcondition {
      condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
      error_message = "Invalid AZ"
    }
  }

}
