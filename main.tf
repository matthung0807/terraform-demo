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

module "services" {
  source = "./ec2"

  instance_ami  = "ami-0e60b6d05dc38ff11"
  instance_type = "t2.micro"
  instance_name = "TerraformProvisionDemo"
}
