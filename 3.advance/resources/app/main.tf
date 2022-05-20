terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
      source        = "hashicorp/aws"
      version       = "3.67.0"
    }
  }
  required_version  = "~> 1.1"
}

provider "aws" {
  region       = var.region
}

data "terraform_remote_state" "vpc" {
  backend           = "s3"
  workspace         = "dev"
  config = {
      bucket        = var.bucket
      key           = "resources/DEV/infra.tfstate"
      region        = var.region
  }
}

#Create ALB
module "alb" {
  source                = "./compute/alb"
  project               = var.project
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  name                  = var.alb_name 
  subnets               = data.terraform_remote_state.vpc.outputs.subnet_pub_id
  internal              = false  
}

#ALB Rule to Point Nginx
module "alb-rule-nginx" {
  source                = "./compute/alb-rule"
  project               = var.project
  name                  = "ngin-static"
  listener_arn          = module.alb.alb_listener_http_arn
  target_group_arn      = module.nginx-static.tg_arn
  condition_value       = ["/"]
}

#ALB Rule to Point Nodejs API
module "alb-rule-nodejs" {
  source                = "./compute/alb-rule"
  project               = var.project
  name                  = "nodejs-api"
  listener_arn          = module.alb.alb_listener_http_arn
  target_group_arn      = module.nodejs.tg_arn
  condition_value       = ["/api"]
}

#Create Nginx ASG
module "nginx-static" {
  source                = "./compute/autoscale"
  project               = var.project
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  name                  = var.name_nginx
  image_id              = var.image_id_nginx
  key_name              = var.key_name
  instance_type         = var.instance_type
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  tg_port               = 80
  vpc_zone_identifier   = data.terraform_remote_state.vpc.outputs.subnet_priv_id
}

#Create NodeJs ASG
module "nodejs" {
  source                = "./compute/autoscale"
  project               = var.project
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  name                  = var.name_nodejs
  image_id              = var.image_id_nodejs
  key_name              = var.key_name
  instance_type         = var.instance_type
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  tg_port               = 80
  vpc_zone_identifier   = data.terraform_remote_state.vpc.outputs.subnet_priv_id
}

#Create Caceh Redis
module "redis" {
  source                = "./data/redis"
  project               = var.project
  cluster_id            = var.cluster_id
  node_type             = var.node_type
  redis_engine_version  = var.redis_engine_version
  subnet_ids_redis      = data.terraform_remote_state.vpc.outputs.subnet_data_id
}

#Create RDS Mysql
module "mysql" {
  source               =  "./data/rds"
  project              = var.project
  identifier           = "${terraform.workspace}-${var.identifier}"
  storage_type         = var.storage_type
  db_engine            = var.db_engine
  allocated_storage    = var.allocated_storage
  rds_engine_version   = var.rds_engine_version
  parameter_group_name = var.parameter_group_name
  instance_class       = var.instance_class
  username             = var.username
  subnet_ids_rds       = data.terraform_remote_state.vpc.outputs.subnet_data_id
}

