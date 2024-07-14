ec2_instance_count = 0

ec2_instance_config_list = [{
  ami           = "ubuntu"
  instance_type = "t2.micro"
  },
  {
    ami           = "nginx"
    instance_type = "t2.micro"
  }
]
