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

resource "aws_security_group" "public_http_traffic" {
  description = "Security group allowing traffic on ports 443 and 80"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.weijie-vpc.id
}

resource "aws_instance" "compute" {
  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]
  subnet_id              = aws_subnet.weijie-public-subnet.id
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type
  }
  tags = merge(var.additional_tags, {
    ManagedBy = "terraform"
  })
}
