module "networking" {
  source   = "./modules/networking"
  vpc_cidr = "10.0.0.0/24"
}
