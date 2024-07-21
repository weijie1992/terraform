module "networking" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/24"
    name       = "13-local-modules"
  }
}
