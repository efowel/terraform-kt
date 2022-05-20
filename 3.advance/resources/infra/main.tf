terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
      source       = "hashicorp/aws"
      version      = "3.67.0"
    }
  }
  required_version = "~> 1.1"
}

provider "aws" {
  region       = var.region
  #assume_role {
  #  role_arn     = "arn:aws:iam::xxx:role/terraform-role"
  #  session_name = "assume-production"
  #}
}

##Create VPC
module "vpc" {
  source                    = "./vpc"
  cidr_block                = var.vpc_cidr_block
  name                      = var.vpc_name
  project                   = var.project
  #nat_subnet_id             = var.project
}

##Create RouteTables and Standard Subnet Public,Private,Data
module "standard-subnets" {
  source                    = "./subnets"
  vpc_id                    = module.vpc.vpc_id
  igw_id                    = module.vpc.vpc_igw_id
  public_cidr_block         = var.subnet_public_cidr
  private_cidr_block        = var.subnet_private_cidr
  data_cidr_block           = var.subnet_data_cidr
  project                   = var.project
}

#Outputs For VPC
output "vpc_id"                 {  value = module.vpc.vpc_id }
output "vpc_cidr"               {  value = module.vpc.vpc_cidr }
output "vpc_igw_id"             {  value = module.vpc.vpc_igw_id }

#Outputs For Subnet
output "subnet_pub_cidr"        {  value = module.standard-subnets.public_cidr }
output "subnet_pub_id"          {  value = module.standard-subnets.public_sub_id }
output "subnet_priv_cidr"       {  value = module.standard-subnets.private_cidr }
output "subnet_priv_id"         {  value = module.standard-subnets.private_sub_id }
output "subnet_data_cidr"       {  value = module.standard-subnets.data_cidr }
output "subnet_data_id"         {  value = module.standard-subnets.data_sub_id }

#output "nat_ip"        {  value = aws_eip.nat_gateway.public_ip }