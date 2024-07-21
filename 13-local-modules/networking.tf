module "networking" {
  source = "./modules/networking"
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
      az         = "ap-southeast-1b"
    }
  }
}
