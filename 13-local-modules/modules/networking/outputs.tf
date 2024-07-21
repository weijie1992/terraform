output "public_subnet" {
  value = local.public_subnet
}
output "vpc_id" {
  description = "The AWS ID from the created VPC"
  value       = aws_vpc.this.id
}

locals {
  output_public_subnets = {
    for key in keys(local.public_subnet) : key => {
      subnet_id        = aws_subnet.this[key].id
      availablity_zone = aws_subnet.this[key].availability_zone
    }
  }
  output_private_subnets = {
    for key in keys(local.private_subnet) : key => {
      subnet_id        = aws_subnet.this[key].id
      availablity_zone = aws_subnet.this[key].availability_zone
    }
  }
}
output "output_public_subnets" {
  description = "The ID and AZ of public subnets"
  value       = local.output_public_subnets
}

output "output_private_subnets" {
  description = "The ID and AZ of the private subnet"
  value       = local.output_private_subnets
}
