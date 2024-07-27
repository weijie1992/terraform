locals {
  allow_instance_types = ["t2.micro", "t3.micro"]
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

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main[0].id
  tags = {
    CostCenter = "test"
  }
  root_block_device { //not required
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true
    postcondition {
      condition     = contains(local.allow_instance_types, self.instance_type)
      error_message = "Invalid instance type"
    }
    # postcondition {
    #   condition     = self.availability_zone == "eu-central-1a"
    #   error_message = "Invalid AZ"
    # }
  }
}

check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags["CostCenter"] != "")
    error_message = "Your AWS instance does not have a cost center"
  }
}
