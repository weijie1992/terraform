data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] #Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}
data "aws_caller_identity" "current" {}
output "aws_caller_identity_data" {
  value = data.aws_caller_identity.current
}
data "aws_region" "current" {}
output "aws_region_data" {
  value = data.aws_region.current
}
data "aws_vpc" "default" {
  tags = {
    "Name" = "wj-test"
  }
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
output "subnet_ids" {
  value = data.aws_subnets.default.ids
}
output "subnet_count" {
  value = length(data.aws_subnets.default.ids)
}

data "aws_availability_zones" "available" {
  state = "available"
}
output "azs" {
  value = data.aws_availability_zones.available
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.public_read_bucket.arn}/*"]
    # resources = ["arn:aws:s3:::*/*"
  }
}

resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "weijie-public-read-bucket"
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website.json
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.weijie-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]
  root_block_device { //not required
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}

resource "aws_security_group" "public_http_traffic" {
  description = "Security group allowing traffic on ports 443 and 80"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.weijie-vpc.id

}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

