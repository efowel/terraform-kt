variable "env" {
  description = "infrastructure environment"
  default     = "DEV"
}
variable "project" {
  description = "For Metadata Tags"
  default     = "DiditalBank"
}
variable "region" {
  description = "AWS REGION"
  default     = "ap-southeast-1"
}
variable "bucket" {
  description = "S3 Bucket State Location"
  default     = "dev-justin-terraform-test"
}

#ALB
variable "alb_name"                 { description = "APP Name" }
#variable "default_tgroup"           { description = "ALB Default Target Group" }

#Autoscale
variable "name_nginx"               { description = "APP Name" }
variable "image_id_nginx"           { description = "AMI Id" }
variable "name_nodejs"              { description = "APP Name" }
variable "image_id_nodejs"          { description = "AMI Id" }
variable "key_name"                 { description = "SSH Key Name" }
variable "instance_type"            { description = "EC2 VM Size" }
variable "desired_capacity"         { description = "Desired Instance Number" }
variable "max_size"                 { description = "Max Instance Number" }
variable "min_size"                 { description = "Min Instance Number" }

#Redis
variable "cluster_id"               { description = "Redis Cluster Name" }
variable "node_type"                { description = "Redis Instance Size" }
variable "redis_engine_version"     { description = "Redis Version" }

#RDS
variable "identifier"               { description = "DB Identifier" }
variable "storage_type"             { description = "DB Storage Type" }
variable "db_engine"                { description = "DB Engine Type" }
variable "allocated_storage"        { description = "DB Storage Size" }
variable "rds_engine_version"       { description = "RDS Engine Version" }
variable "parameter_group_name"     { description = "RDS Parameter Group" }
variable "instance_class"           { description = "DB Instance Size" }
variable "username"                 { description = "DB Admin Username" }