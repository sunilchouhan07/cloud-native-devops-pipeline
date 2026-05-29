resource "aws_db_subnet_group" "rds" {
  name = "${var.env}-rds-subet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "rds" {
  name = "${var.env}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"

    cidr_blocks = [var.vpc_cidr]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${var.env}-employee-db"

  engine = "postgres"
  engine_version = "17"
  instance_class = "db.t3.micro"
  allocated_storage = 20 
  username = var.db_username
  password = var.db_password

  db_name = "employee_db"
  publicly_accessible = false
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  db_subnet_group_name = aws_db_subnet_group.rds.name 
  skip_final_snapshot = true
}


