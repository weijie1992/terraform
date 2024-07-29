module "database" {
  source = "./modules/rds"

  project_name = "proj04-rds-module"
  storage_size = 10
  credentials = {
    username = "db-admin"
    password = "abc123?"
  }
}
