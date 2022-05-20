## HOW TO USE
Values to provide
* project - # Value for Tag Key=Project for metadata
* vpc_id - # Value VPC ID
* name - # Name for all resource created
* subnets - # Subnets for ALB
* internal - # True|False to choose between external or internal ALB

```
module "alb" {
  source                = "./compute/alb"
  project               = var.project
  vpc_id                = "vpc_1234acbd"
  name                  = "my-elbv2"
  subnets               = ["subnet-1abcd123", "subnet-2abcd123", "subnet-3abcd123"]
  internal              = false  
}
```

#### Comments
* Usually creates 4 RESOURCES
* Creates Application LoadBalancer, Default ALB Targetgroup, HTTP and HTTPS Listener
  
#### Outputs for Remote Sate Data Source
* dns_name - # DNS name of ALB
* alb_arn - # ALB ARN
* alb_listener_http_arn - # HTTP ARN
* alb_listener_https_arn - # HTTPS ARN
* default_tg_arn - # Default Target group ARN