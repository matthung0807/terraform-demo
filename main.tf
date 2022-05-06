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

resource "aws_s3_bucket_policy" "deny_all_get_object" {
  bucket = aws_s3_bucket.demo_bucket.id
  policy = data.aws_iam_policy_document.deny_all_get_object_document.json
  # policy = <<POLICY
  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  #     {
  #       "Sid": "DenyAllGetObject",
  #       "Effect": "Deny",
  #       "Principal": {
  #         "AWS": "*"
  #       },
  #       "Action": "s3:GetObject",
  #       "Resource": "${aws_s3_bucket.demo_bucket.arn}/*"
  #     }
  #   ]
  # }
  # POLICY
}

data "aws_iam_policy_document" "deny_all_get_object_document" {
  statement {
    sid    = "DenyAllGetObject"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.demo_bucket.arn}/*"]
  }
}
