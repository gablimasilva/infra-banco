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

  db_subnet_group_name = aws_db_subnet_group.postgres.name

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

resource "aws_db_subnet_group" "postgres" {

  name = "vehicle-sales-db-subnet-group"

  subnet_ids = [
    var.subnet_a_id,
    var.subnet_b_id
  ]
}

resource "aws_security_group" "postgres" {

  name   = "vehicle-sales-rds-sg"

  vpc_id = var.vpc_id

  ingress {

    from_port = 5432
    to_port   = 5432

    protocol = "tcp"

    security_groups = [
      var.cluster_security_group_id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
