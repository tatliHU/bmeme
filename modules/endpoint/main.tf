data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.code
  output_path = "${path.module}/tmp/${var.function_name}.zip"
}

resource "aws_lambda_function" "server" {
  filename      = "${path.module}/tmp/${var.function_name}.zip"
  function_name = var.function_name
  role          = var.role

  handler = "main.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.10"
  
  tags = var.tags
}

resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.server.function_name
  authorization_type = "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["*"]
  }
}