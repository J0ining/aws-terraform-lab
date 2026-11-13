output "db_endpoint" {

  value = aws_db_instance.lab_db.endpoint

}


output "db_secret_arn" {

  value = aws_db_instance.lab_db.master_user_secret[0].secret_arn

}

output "db_user" {
  value = aws_db_instance.lab_db.username

}