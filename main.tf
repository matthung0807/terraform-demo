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