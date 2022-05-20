#https://www.terraform.io/language/settings/backends/s3
terraform {
  backend "s3" {
    bucket         = "dev-justin-terraform-test"
    key            = "aws.tfstate"
    region         = "ap-southeast-1"
  }
  required_providers {
    aws = {
      source       = "hashicorp/aws"
      version      = "3.67.0"
    }
  }
  required_version = "~> 1.1"
}

#https://registry.terraform.io/providers/hashicorp/aws/2.43.0/docs
provider "aws" {
  region       = "ap-southeast-1"
}

#######LOCALS######
locals {
  tags = {
    Name                = "${terraform.workspace}-${var.name}"
    PROJECT             = var.project
    WORKSPACE           = "${terraform.workspace}"
  }
}

##Creates VPC
resource "aws_vpc" "main" {
  cidr_block            = var.cidr_block
  instance_tenancy      = "default"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = local.tags
}

##Creates Internet Gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id                =  aws_vpc.main.id
  tags = {
    Name                = "${terraform.workspace}-${var.name}-igw"
    PROJECT             = var.project
    WORKSPACE           = "${terraform.workspace}"
  }
}
