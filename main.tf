terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1" // Tokyo
}

resource "aws_secretsmanager_secret" "demo_secret" {
  name                    = "terraform/secret1"
  recovery_window_in_days = 7
}

variable "key_value_pairs" {
  default = {
    secret = "12345"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "demo_secret_value" {
  secret_id     = aws_secretsmanager_secret.demo_secret.id
  secret_string = jsonencode(var.key_value_pairs)
}
