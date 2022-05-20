#######VARS#######
variable "project"                  { description = "For Metadata Tags" }
variable "cluster_id"               { description = "Redis Cluster Name" }
variable "node_type"                { description = "Redis Instance Size" }
variable "redis_engine_version"     { description = "Redis Version" }
variable "subnet_ids_redis"         { description = "Multi Subnet Placement" }

######OUTPUT######
output "security_group_ids"   { value = aws_elasticache_cluster.redis.security_group_ids }

##Create Subenet Group for REDIS
resource "aws_elasticache_subnet_group" "data-redis" {
  name          = "data-subnet-redis"
  subnet_ids    = var.subnet_ids_redis
  tags = {
    PROJECT     = var.project
    WORKSPACE   = "${terraform.workspace}"
  }
}

##Create Redis Instance
resource "aws_elasticache_cluster" "redis" {
  cluster_id               = var.cluster_id
  engine                   = "redis"
  node_type                = var.node_type
  num_cache_nodes          = 1
  parameter_group_name     = "default.redis3.2"
  engine_version           = var.redis_engine_version
  subnet_group_name        = aws_elasticache_subnet_group.data-redis.name
  port                     = 6379
  tags = {
    Name        = "${terraform.workspace}-${var.cluster_id}-mysql"
    PROJECT     = var.project
    WORKSPACE   = "${terraform.workspace}"
  }
}



