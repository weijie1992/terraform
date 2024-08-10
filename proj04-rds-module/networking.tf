########################
# VPC and Subnets
########################
resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/24"
  tags = {
    name = "proj04-custom"
  }
}

moved {
  from = aws_subnet.allowed
  to   = aws_subnet.private1
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.0.0/28"
  tags = {
    name   = "proj04-custom-vpc-private1"
    Access = "private"
  }
  availability_zone = "ap-southeast-1a"
}
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.0.16/28"
  tags = {
    name   = "proj04-custom-vpc-private2"
    Access = "private"
  }
  availability_zone = "ap-southeast-1b"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.0.32/28"
  tags = {
    name = "proj04-custom-vpc-public-1"
  }
}

########################
# Security Groups
########################

# 1. Source security group - From where traffic is allowed
# 2. Compliant Security group
#   2.1 Security group rule
# 3. Non-compliant security group
#   3.1 security group rule

resource "aws_security_group" "source" {
  name        = "source-sg"
  description = "Source Security Group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_security_group" "compliant" {
  name        = "Compliant-sg"
  description = "Compliant Security Group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_security_group" "non-compliant" {
  name        = "Non-compliant-sg"
  description = "Non-Compliant Security Group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.non-compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
