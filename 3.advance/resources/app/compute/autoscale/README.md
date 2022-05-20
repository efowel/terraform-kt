## HOW TO USE
Values to provide
* project - # Value for Tag Key=Project for metadata
* vpc_id - # Value VPC ID
* name - # Name for all resource created
* image_id - # AMI ID to be used
* key_name - # SSH Key to be used
* instance_type - # Instance size
* desired_capacity - # Desired number for ASG
* max_size - # ASG max size
* min_size - # ASG min size
* tg_port - # Target group port for the ASG
* vpc_zone_identifier - # List of subnets on where to deploy to


```
module "nodejs" {
  source                = "./compute/autoscale"
  project               = var.project
  vpc_id                = "vpc_1234acbd"
  name                  = "My-NODE-JS-APP"
  image_id              = "ami-1234abcd"
  key_name              = "my-ssh-key"
  instance_type         = "t3.megalarge"
  desired_capacity      = 3
  max_size              = 6
  min_size              = v2
  tg_port               = 80
  vpc_zone_identifier   = ["subnet-1abcd123", "subnet-2abcd123", "subnet-3abcd123"]
}
```

#### Comments
* Usually creates 4 RESOURCES
* Creates Launch Template, Autosacling Group, ALB Targetgroup
  
#### Outputs for Remote Sate Data Source
* id - # Autoscaling id
* tg_arn - # Target group ARN
