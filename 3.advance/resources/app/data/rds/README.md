## HOW TO USE
Values to provide
* project - # Value for Tag Key=Project for metadata
* identifier - # Name for all resource created
* storage_type - # Storage Class, gp2, IOPS etc.
* db_engine - # Choose either Mysql, MariaDB, PosgreSQL etc
* allocated_storage - # Storage size in Gigabyte
* rds_engine_version - # Engine Version
* instance_class - # Instance Size
* username - # Database username
* subnet_ids_rds - # Subnets for RDS

```
module "mysql" {
  source               =  "./data/rds"
  project              = "MyProject"
  identifier           = "My-Database"
  storage_type         = "gp2"
  db_engine            = "mysql"
  allocated_storage    = "100"
  rds_engine_version   = "5.7"
  parameter_group_name = var.parameter_group_name
  instance_class       = "db.t2.small"
  username             = "mysql-admin"
  subnet_ids_rds       = ["subnet-12345"]
}
```

#### Comments
* Usually creates 5 RESOURCES
* Creates Random Password, AWS SecretKey, RDS Instance, RDS Subnet Group
  
#### Outputs for Remote Sate Data Source
* rds_endpoint - # DNS name of RDS