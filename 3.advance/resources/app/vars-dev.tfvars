project             = "DigitalBank"

#ALB
alb_name            = "main"

#Nginx
name_nginx          = "nginx-static" 
image_id_nginx      = "ami-07f179dc333499419"

#NodeJS
name_nodejs         = "nodejs-api" 
image_id_nodejs     = "ami-07f179dc333499419"
key_name            = "test2"
instance_type       = "t2.micro"
desired_capacity    = 2
max_size            = 3
min_size            = 2

#Redis
cluster_id            = "redis-cluster"
node_type             = "cache.t2.micro"
redis_engine_version  = "3.2.10"

#RDS
allocated_storage       = 10
storage_type            = "gp2"
db_engine               = "mysql"
parameter_group_name    = "default.mysql5.7"
rds_engine_version      = "5.7"
instance_class          = "db.t3.micro"
identifier              = "testrds"
username                = "testadmin"
  