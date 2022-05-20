#######VARS#######
variable "project"             { description = "For Metadata Tags" }
variable "name"                { description = "ALB Name" }
variable "vpc_id"              { description = "VPC ID" }
variable "subnets"             { description = "ALB SUBNETS" }
#variable "security_groups"    { description = "ALB SecGroup" }
variable "internal"            { description = "Internal | External bool" }
#variable "default_tgroup"      { description = "ALB Default Target Group" }

######OUTPUT######
output "dns_name"                 {  value = aws_alb.alb.dns_name }
output "alb_arn"                  {  value = aws_alb.alb.arn }
output "alb_listener_http_arn"    {  value = aws_alb_listener.http.arn }
output "default_tg_arn"           {  value = aws_alb_target_group.default.arn }


resource "aws_alb_target_group" "default" {
  name                  = "${terraform.workspace}-${var.name}"
  port                  = 80
  protocol              = "HTTP"
  vpc_id                = var.vpc_id
  tags = {
    Name                = "${terraform.workspace}-${var.name}-default-tg"
    PROJECT             = var.project
    WORKSPACE           = "${terraform.workspace}"
  }
}

resource "aws_alb" "alb" {  
  name              = "${terraform.workspace}-${var.name}-alb" 
  subnets           = var.subnets
  #security_groups  = var.security_groups
  internal          = var.internal    
  tags = {
    Name          = "${terraform.workspace}-${var.name}-alb"
    PROJECT       = var.project
    WORKSPACE     = "${terraform.workspace}"
  }
  #access_logs {    
  #  bucket = "${var.s3_bucket}"    
  #  prefix = "ELB-logs"  
  #}
}

##For HTTP Traffic
resource "aws_alb_listener" "http" {  
  load_balancer_arn     = aws_alb.alb.arn  
  port                  = 80 
  protocol              = "HTTP"
  default_action {    
    target_group_arn    = aws_alb_target_group.default.arn
    type                = "forward"  
  }
}

##For HTTPS Traffic, CERT Required
#resource "aws_alb_listener" "https" {  
#  load_balancer_arn     = aws_alb.alb.arn  
#  port                  = 443 
#  protocol              = "HTTPS"
#    default_action {    
#    target_group_arn    = aws_alb_target_group.default.arn
#    type                = "forward"  
#  }
#}