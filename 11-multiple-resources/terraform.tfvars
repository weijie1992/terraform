ec2_instance_count = 0

ec2_instance_config_list = [
  # {
  # ami           = "nginx"
  # instance_type = "t2.micro"
  # },
  # {
  #   ami           = "ubuntu"
  #   instance_type = "t2.micro"
  # }
]

ec2_instance_config_map = {
  ubuntu_1 = {
    ami           = "ubuntu"
    instance_type = "t2.micro"
  },
  nginx_1 = {
    ami           = "nginx"
    instance_type = "t2.micro"
    subnet_index  = 1
  }
}
