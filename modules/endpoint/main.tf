# Role to run lambda
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "local_file" "code" {
  content  = var.code
  filename = "${path.module}/code.py"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/code.py"
  output_path = "${path.module}/lambda_function_payload.zip"
  depends_on  = [local_file.code]
}

resource "aws_lambda_function" "server" {
  filename      = "${path.module}/lambda_function_payload.zip"
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn

  handler = "code.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.10"
  
  tags = var.tags
}

resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.server.function_name
  authorization_type = "NONE"
}