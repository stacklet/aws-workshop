resource "aws_efs_file_system" "positive1" {
  creation_token = "my-product"
}

resource "aws_efs_file_system" "positive2" {
  creation_token = "my-product"
  encrypted      = false
}

resource "aws_efs_file_system" "positive2" {
  creation_token = "my-product"
  encrypted      = "false"
}
