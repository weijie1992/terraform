/*
1. terraform state mv ARGS ...

*/

locals {
  instance_type = "t2.micro"
  ec2_name      = ["instance_1", "instance_2"]
}
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

resource "aws_instance" "new_list" {
  for_each = toset(local.ec2_name)

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance_type
  subnet_id     = aws_subnet.main.id
}

moved {
  from = aws_instance.new_list[0]
  to   = aws_instance.new_list["instance_1"]
}
moved {
  from = aws_instance.new_list[1]
  to   = aws_instance.new_list["instance_2"]
}
