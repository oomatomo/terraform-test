# https://www.terraform.io/docs/backends/types/s3.html
terraform {
  backend "s3" {
    region = "ap-northeast-1"
    key = "state"
  }
}
