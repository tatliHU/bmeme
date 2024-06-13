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
  tags               = var.tags
}

module login {
  source        = "./modules/endpoint"
  function_name = "login"
  code          = "scripts/login"
  role          = aws_iam_role.iam_for_lambda.arn
}

module index {
  source        = "./modules/endpoint"
  function_name = "index"
  code          = "scripts/index"
  role          = aws_iam_role.iam_for_lambda.arn
}