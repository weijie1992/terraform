########################
# Subnet validation
########################
data "aws_vpcs" "default" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}
locals {
  default_vpc_exists = length(data.aws_vpcs.default.ids) > 0
  default_vpc_id     = local.default_vpc_exists ? data.aws_vpcs.default.ids[0] : ""
}

locals {
  ids = ["abc", "def"]
}
output "test" {
  value = toset(local.ids)
}

data "aws_subnet" "input" {
  for_each = toset(var.subnet_ids)
  id       = each.value

  lifecycle {
    postcondition {
      condition     = local.default_vpc_exists ? self.vpc_id != local.default_vpc_id : true
      error_message = <<-EOT
        The following subnet is part of the default VPC.

        Name = ${self.tags.name}
        ID = ${self.id}

        Please do not deploy RDS instances in the default VPC.
      EOT
    }
    postcondition {
      condition     = can(lower(self.tags.Access) == "private")
      error_message = <<-EOT
          The following subnet is not marked as private:

          Name = ${self.tags.name}
          ID = ${self.id}

          Please ensure that the subnet is properly tagged by adding the following tags
          1. Access = "private"
      EOT
    }
  }
}


########################
# Security group validation
########################
data "aws_vpc_security_group_rules" "input" {
  filter {
    name   = "group-id"
    values = var.security_group_ids
  }
}


data "aws_vpc_security_group_rule" "input" {
  for_each               = toset((data.aws_vpc_security_group_rules.input.ids))
  security_group_rule_id = each.value

  lifecycle {
    postcondition {
      condition = (
        self.is_egress ? true : self.cidr_ipv4 == null && self.cidr_ipv6 == null && self.referenced_security_group_id != null
      )
      error_message = <<-EOT
      The following security group contains an invalid inbound rules: 

      ID = ${self.security_group_id}
      
      Please ensure that the following conditions are met:
      1. Rules must not allow inbound traffic from IP CIDR blocks, only from other security group
      EOT
    }
  }
}
