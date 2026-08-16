module "postgres" {

  source = "./modules/postgres"

  db_name        = var.db_name
  instance_class = var.instance_class

  db_username = var.db_username
  db_password = var.db_password

  vpc_id                    = var.vpc_id
  subnet_a_id               = var.subnet_a_id
  subnet_b_id               = var.subnet_b_id
  cluster_security_group_id = var.cluster_security_group_id
}