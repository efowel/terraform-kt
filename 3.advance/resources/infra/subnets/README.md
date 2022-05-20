## HOW TO USE
Values to provide
* project - # Value for Tag Key=Project for metadata
* vpc_id - # Value VPC ID
* igw_id - # Value InternetGateway ID
* public_cidr_block - # Pulic CIDR Block for each AZ
* private_cidr_block - # Private CIDR Block for each AZ
* data_cidr_block - # Data CIDR Block for each AZ
```
module "standard-subnets" {
  source               = "./subnets"
  project              = var.project
  vpc_id               = "vpc_1234acbd"
  igw_id               = "igw_1234abcd"
  public_cidr_block    = ["10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]
  private_cidr_block   = ["10.0.21.0/24","10.0.22.0/24","10.0.23.0/24"]
  data_cidr_block      = ["10.0.31.0/24","10.0.32.0/24","10.0.33.0/24"]
}
```

#### Comments
* Usually creates 18-21 RESOURCES
* Creates Subnets, RouteTables, and RouteTable-Assoc
  
#### Outputs for Remote Sate Data Source
* public_cidr - # Public Subnet CIRD
* public_sub_id - # Public Subnet ID
* private_cidr - # Private Subnet CIRD
* private_sub_id - # Private Subnet ID
* data_cidr - # Data Subnet CIRD
* data_sub_id - # Data Subnet ID
