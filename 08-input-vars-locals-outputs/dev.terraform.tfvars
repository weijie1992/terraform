ec2_instance_type = "t2.micro"

ec2_volume_config = {
  size = 12
  type = "gp2"
}

additional_tags = {
  "ValuesFrom" = "dev.terraform.tfvars"
}
