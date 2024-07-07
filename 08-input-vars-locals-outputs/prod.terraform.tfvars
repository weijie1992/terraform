ec2_instance_type = "t2.micro"

ec2_volume_config = {
  size = 11
  type = "gp2"
}

additional_tags = {
  "ValuesFrom" = "prod.terraform.tfvars"
}
