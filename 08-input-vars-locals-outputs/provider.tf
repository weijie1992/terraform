terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "weijie-vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Weijie Terraform VPC"
  }
}

resource "aws_subnet" "weijie-public-subnet" {
  vpc_id     = aws_vpc.weijie-vpc.id
  cidr_block = "10.0.0.0/28"
}

resource "aws_internet_gateway" "weijie-igw" {
  vpc_id = aws_vpc.weijie-vpc.id
}

resource "aws_route_table" "weijie-public-rt" {
  vpc_id = aws_vpc.weijie-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.weijie-igw.id
  }
}
resource "aws_route_table_association" "weijie-route-table-association" {
  subnet_id      = aws_subnet.weijie-public-subnet.id
  route_table_id = aws_route_table.weijie-public-rt.id
}
