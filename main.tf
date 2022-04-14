terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1" // Tokyo
}

// KMS key configs
resource "aws_kms_key" "demo_key" {
  description              = "terraform demo key"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 7
}

resource "aws_kms_alias" "demo_key_alias" {
  name          = "alias/TerraformDemoKey"
  target_key_id = aws_kms_key.demo_key.key_id
}
