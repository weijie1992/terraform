module "networking-tf-course" {
  source  = "weijie1992/networking-tf-course/aws"
  version = "0.0.1"
  # insert the 2 required variables here
  vpc_config = {
    cidr_block = "10.0.0.0/24"
    name       = "13-local-modules"
  }
  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/28"
      az         = "ap-southeast-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.0.16/28"
      public     = true
      az         = "ap-southeast-1b"
    }
  }
}
