resource "aws_dynamodb_table" "users" {
  name           = "user"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  table_class    = "STANDARD"

  attribute {
    name = "UserName"
    type = "S"
  }
  hash_key       = "UserName"
  ttl {
    enabled        = false
    attribute_name = "TimeToExist" # Required but unused field
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [ttl]
  }
}