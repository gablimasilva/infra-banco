resource "aws_db_instance" "postgres" {

  identifier = "vehicle-sales-db"

  engine = "postgres"

  engine_version = "17"

  instance_class = var.instance_class

  allocated_storage = 20

  storage_type = "gp3"

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  publicly_accessible = false

  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.postgres.id
  ]
}

resource "aws_secretsmanager_secret" "database" {

  name = "vehicle-sales-db-secret"
}

resource "aws_secretsmanager_secret_version" "database" {

  secret_id = aws_secretsmanager_secret.database.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    database = var.db_name
  })
}