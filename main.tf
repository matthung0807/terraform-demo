terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12"
    }
  }

  required_version = ">= 1.1.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1" // Tokyo
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "terraform-demo-bucket-202205052200"
}

resource "aws_s3_access_point" "demo_bucket_access_point" {
  bucket = aws_s3_bucket.demo_bucket.id
  name   = "terraform-demo-bucket"
}

resource "aws_s3control_access_point_policy" "demo_bucket_access_point_policy" {
  access_point_arn = aws_s3_access_point.demo_bucket_access_point.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid = "DenyAllGetObject"
      Effect = "Deny"
      Principal = {
        AWS = "*"
      }
      Action = "s3:GetObject"
      Resource = "${aws_s3_access_point.demo_bucket_access_point.arn}/object/*"
    }]
  })
}