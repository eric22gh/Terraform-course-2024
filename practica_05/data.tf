data "aws_key_pair" "cloud_key" { # data lee recursos de aws que ya existen, tambien se puede usar con roles.
  key_name = "cloud"
}
