## HOW TO USE
Values to provide
* project - # Value for Tag Key=Project for metadata
* cluster_id - # Name for all resource created
* node_type - # Redis Instance Size
* db_engine - # Choose either Memcache or  Redis
* redis_engine_version - # Redis Version
* subnet_ids_redis - # Subnets for Redis

```
module "redis" {
  source                = "./data/redis"
  project               = "MyREdis Project"
  cluster_id            = "redis-cluster"
  node_type             = "cache.t2.micro"
  redis_engine_version  = "3.2.10"
  subnet_ids_redis      = ["subnet-abc123"]
}
```

#### Comments
* Usually creates 2 RESOURCES
* Redis Instance, Redis Subnet Group
  
#### Outputs for Remote Sate Data Source
* security_group_ids - # Redis Secgroup