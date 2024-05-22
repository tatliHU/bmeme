module login {
  source        = "./modules/endpoint"
  function_name = "login"
  code          = file("scripts/login.py")
}