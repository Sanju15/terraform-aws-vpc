# variable "aws_region_state_s3" {
#   description = "value for AWS region where we need the s3 bucket for terraform state file"
# }

provider "aws" {
  region = "us-east-1"
}

resource "aws_kms_key" "kms_s3_pro" {
  description = "The key is for terraform state file which is created in s3 for project pro"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "pro_state_file_s3" {
  bucket = "pro-terraform-state"

  tags = {
    Name = "pro-terraform-state"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning_pro_s3_for_tf_state_file" {
  bucket = aws_s3_bucket.pro_state_file_s3.id
  versioning_configuration {
    status = "Enabled"
}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.pro_state_file_s3.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms_s3_pro.id
      sse_algorithm = "aws:kms"
    }
  }
  depends_on = [aws_kms_key.kms_s3_pro, aws_s3_bucket.pro_state_file_s3]
}