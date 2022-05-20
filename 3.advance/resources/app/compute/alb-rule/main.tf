#######VARS#######
variable "action_type" {
  description = "ALB Action Blocks"
  default     = "forward"
}
variable "project"                  { description = "For Metadata Tags" }
variable "name"                     { description = "APP Name" }
variable "listener_arn"             { description = "Listener ARN" }
variable "target_group_arn"         { description = "SSH Key Name" }
variable "condition_value"          { description = "SSH Key Name" }
#variable "condition_field"          { description = "SSH Key Name" }
#variable "depends_on"               { description = "Set dependent codition before creation [list]" }

######OUTPUT#######

resource "aws_alb_listener_rule" "listener_rule" {
  listener_arn       = var.listener_arn
  action {    
    type             = var.action_type  
    target_group_arn = var.target_group_arn 
  }   
  condition {
    path_pattern {
      values = var.condition_value
    }
  }
  tags = {
    Name             = "${terraform.workspace}-${var.name}-rule"
    PROJECT          = var.project
    WORKSPACE        = "${terraform.workspace}"
  }
  #priority           = var.priority
  #depends_on         = var.depends_on
}