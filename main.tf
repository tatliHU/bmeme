module register {
  source        = "./modules/endpoint"
  function_name = "register"
  code          = "scripts/register"
  role          = aws_iam_role.lambda_db_rw.arn
}

module login {
  source        = "./modules/endpoint"
  function_name = "login"
  code          = "scripts/login"
  role          = aws_iam_role.basic_lambda.arn
}

module index {
  source        = "./modules/endpoint"
  function_name = "index"
  code          = "scripts/index"
  role          = aws_iam_role.basic_lambda.arn
}