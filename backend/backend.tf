terraform {
  backend "s3" {
    bucket = "pro-terraform-state"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}