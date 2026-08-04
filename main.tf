module "postgres" {
  source = "./modules/postgres"

  db_name        = var.db_name
  instance_class = var.instance_class

  db_username = var.db_username
  db_password = var.db_password
}