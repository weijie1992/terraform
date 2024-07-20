ec2_instance_config_map = {
  ubuntu_1 = {
    ami           = "ubuntu"
    instance_type = "t2.micro"
  },
  nginx_1 = {
    ami           = "nginx"
    instance_type = "t2.micro"
    subnet_name   = "subnet_1"
  }
}

subnet_config = {
  default = {
    cidr_block = "10.0.0.0/28"
  }
  subnet_1 = {
    cidr_block = "10.0.0.16/28"
  }
}
