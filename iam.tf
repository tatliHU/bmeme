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

# Lambda-only role
resource "aws_iam_role" "basic_lambda" {
  name               = "basic_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

# Lambda role with DB read-write permission
resource "aws_iam_role" "lambda_db_rw" {
  name               = "lambda_db_rw"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "db_rw" {
  statement {
    effect    = "Allow"
    actions   = [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DescribeTable",
        "dynamodb:Query",
        "dynamodb:Scan"
        ]
    resources = [aws_dynamodb_table.users.arn]
  }
}

resource "aws_iam_policy" "db_rw" {
  name        = "db_rw"
  description = "Write only access to DB"
  policy      = data.aws_iam_policy_document.db_rw.json
}

resource "aws_iam_role_policy_attachment" "db_rw" {
  role       = aws_iam_role.lambda_db_rw.name
  policy_arn = aws_iam_policy.db_rw.arn
}