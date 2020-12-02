terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

module "politicas"{
  source  = "./politica"
}

module "S3" {
  source  = "./S3"
}

module "RDS" {
  source  = "./RDS"
}

module "ec2" {
  source  = "./ec2"
}
