## HOW TO USE
Values to provide
* project    - # Value for Tag Key=Project for metadata
* name       - # Name of the VPC and IGW
* cidr_block - # CIDR IP Block of VPC
```
module "vpc" {
  source            = "./vpc"
  project           =  "MY-PROJECT"
  name              =  "MY-VPC"
  cidr_block        =  "192.168.0.0/16"
```

#### Comments
* Usually creates 2 RESOURCES
* Creates VPC and IGW

#### Outputs for Remote Sate Data Source
* vpc_id
* vpc_cidr
* vpc_igw_id