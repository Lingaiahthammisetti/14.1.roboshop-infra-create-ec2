terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }

  backend "s3" {
    bucket = "roboshop-ec2-remote-state"
    key    = "roboshop-create-ec2-key"
    region = "us-east-1"
    dynamodb_table = "roboshop-ec2-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}