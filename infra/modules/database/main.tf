resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "Security Group for Compute Resources"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Database Security Group"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_from_instances" {
  security_group_id            = aws_security_group.database_sg.id
  referenced_security_group_id = var.compute_sg_id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
  description                  = "Database Ingress rule for communication from instances to database"
}

## Instances rule
resource "aws_vpc_security_group_egress_rule" "allow_to_db" {
  security_group_id            = var.compute_sg_id
  referenced_security_group_id = aws_security_group.database_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
  description                  = "Compute Egress rule for communication from instances to database"
}

resource "aws_db_subnet_group" "db_private_subnet_group" {
  name       = "db-private-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "Main DB subnet group"
  }
}

resource "aws_db_instance" "lab_db" {
  #checkov:skip= CKV_AWS_353: Performance insights not necessary for the lab
  #checkov:skip= CKV_AWS_129: Logging in RDS no necessary for the lab
  #checkov:skip= CKV_AWS_157: Multi-AZ disabled for this lab. Can be enable again from root module for testing
  #checkov:skip= CKV_AWS_118: Enchanced monitoring not necessary for the lab.
  #checkov:skip= CKV_AWS_293: Protection deletation not needed for lab
  #checkov:skip= CKV2_AWS_30: Query Loggin not necessary for the lab
  identifier                          = "lab-db-instance"
  allocated_storage                   = 20
  storage_type                        = "gp3"
  db_name                             = "mydb"
  engine                              = "postgres"
  engine_version                      = "18"
  instance_class                      = "db.t3.micro"
  db_subnet_group_name                = aws_db_subnet_group.db_private_subnet_group.name
  manage_master_user_password         = true
  username                            = var.db_user
  skip_final_snapshot                 = true
  vpc_security_group_ids              = [aws_security_group.database_sg.id]
  publicly_accessible                 = false
  storage_encrypted                   = true
  multi_az                            = var.db_multi_az
  auto_minor_version_upgrade          = true
  iam_database_authentication_enabled = true
  copy_tags_to_snapshot               = true
}
