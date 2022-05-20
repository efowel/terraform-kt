#######VARS#######
variable "project"                  { description = "For Metadata Tags" }
variable "name"                     { description = "APP Name" }
variable "image_id"                 { description = "AMI Id" }
variable "key_name"                 { description = "SSH Key Name" }
variable "instance_type"            { description = "EC2 VM Size" }
variable "desired_capacity"         { description = "Desired Instance Number" }
variable "max_size"                 { description = "Max Instance Number" }
variable "min_size"                 { description = "Min Instance Number" }
variable "vpc_zone_identifier"      { description = "Subnet Placement for Instance" }
variable "vpc_id"                   { description = "Subnet Placement for Instance" }
variable "tg_port"                  { description = "Port for Target Group" }


######OUTPUT######
output "id"                 {  value = aws_launch_template.app.id }
output "tg_arn"             {  value = aws_alb_target_group.app.arn }


resource "aws_alb_target_group" "app" {
  name                  = "${terraform.workspace}-${var.name}"
  port                  = var.tg_port
  protocol              = "HTTP"
  vpc_id                = var.vpc_id
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = var.tg_port  
  }
  tags = {
    Name                = "${terraform.workspace}-${var.name}-tg"
    PROJECT             = var.project
    WORKSPACE           = "${terraform.workspace}"
  }
}

resource "aws_autoscaling_attachment" "app" {
  alb_target_group_arn   = aws_alb_target_group.app.arn
  autoscaling_group_name = aws_autoscaling_group.app.id
}

resource "aws_launch_template" "app" {
  name                      = var.name
  image_id                  = var.image_id
  key_name                  = var.key_name
  instance_type             = var.instance_type
  tags = {
    Name                    = "${terraform.workspace}-${var.name}-template"
    PROJECT                 = var.project
    WORKSPACE               = "${terraform.workspace}"
  }
}

resource "aws_autoscaling_group" "app" {
  name                      = "${terraform.workspace}-${var.name}"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.vpc_zone_identifier
  launch_template {
    id                      = aws_launch_template.app.id
    version                 = "$Latest"
  }
  lifecycle {
    ignore_changes = [target_group_arns]
  }
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "${terraform.workspace}-${var.name}"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "PROJECT"
        "value"               = "var.project"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "WORKSPACE"
        "value"               = "${terraform.workspace}"
        "propagate_at_launch" = true
      }
    ]
  )
}