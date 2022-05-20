
#######VARS#######
variable "project"             { description = "For Metadata Tags" }
variable "vpc_id"              { description = "VPC ID" }
variable "igw_id"              { description = "IGW ID" }
variable "public_cidr_block"   { type = list }
variable "private_cidr_block"  { type = list }
variable "data_cidr_block"     { type = list }

######OUTPUT######
output "public_cidr"              {  value = [for s in var.public_cidr_block: s] }
output "public_sub_id"            {  value = [for s in aws_subnet.public-subnet: s.id ] }
output "private_cidr"             {  value = [for s in var.private_cidr_block: s] }
output "private_sub_id"           {  value = [for s in aws_subnet.private-subnet: s.id ] }
output "data_cidr"                {  value = [for s in var.data_cidr_block: s] }
output "data_sub_id"              {  value = [for s in aws_subnet.data-subnet: s.id ] }

data "aws_availability_zones" "available" {
  state = "available"
}

####PUBLIC SUBNET####
##Creates Subnets Based on Number of AZ in the Region
resource "aws_subnet" "public-subnet" {
  count               = length(tolist(data.aws_availability_zones.available.names))
  cidr_block          = var.public_cidr_block[count.index]
  vpc_id              = var.vpc_id
  availability_zone   = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${terraform.workspace}-public-${data.aws_availability_zones.available.names[count.index]}"
    PROJECT           = var.project
    WORKSPACE         = "${terraform.workspace}"
  }
}
##Points External Routes to IGW
resource "aws_route_table" "public" {
  vpc_id              = var.vpc_id
  route {
  cidr_block          = "0.0.0.0/0"       
  gateway_id          = var.igw_id
  }
  tags = {
    Name              = "${terraform.workspace}-public-rt"
    PROJECT           = var.project
    WORKSPACE         = "${terraform.workspace}"
  }
}
##Attach the subnet to the route table
resource "aws_route_table_association" "public-rt-associate" {
  count               = length(var.public_cidr_block)
  subnet_id           = aws_subnet.public-subnet[count.index].id
  route_table_id      = aws_route_table.public.id
}
######################

####PRIVATE SUBNET####
##Creates Subnets Based on Number of AZ in the Region
resource "aws_subnet" "private-subnet" {
  count               = length(tolist(data.aws_availability_zones.available.names))
  cidr_block          = var.private_cidr_block[count.index]
  vpc_id              = var.vpc_id
  availability_zone   = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${terraform.workspace}-private-${data.aws_availability_zones.available.names[count.index]}"
    PROJECT           = var.project
    WORKSPACE         = "${terraform.workspace}"
  }
}
##Points External Routes to IGW
resource "aws_route_table" "private" {
  vpc_id              = var.vpc_id
  route {
  cidr_block          = "0.0.0.0/0"       
  gateway_id          = var.igw_id #shoud be chaged to Natgateway
  }
  tags = {
    Name              = "${terraform.workspace}-private-rt"
    PROJECT           = var.project
    WORKSPACE         = "${terraform.workspace}"
  }
}
##Attach the subnet to the route table
resource "aws_route_table_association" "private-rt-associate" {
  count               = length(var.private_cidr_block)
  subnet_id           = aws_subnet.private-subnet[count.index].id
  route_table_id      = aws_route_table.private.id
}
######################

####DATA SUBNET####
##Creates Subnets Based on Number of AZ in the Region
resource "aws_subnet" "data-subnet" {
  count               = length(tolist(data.aws_availability_zones.available.names))
  cidr_block          = var.data_cidr_block[count.index]
  vpc_id              = var.vpc_id
  availability_zone   = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${terraform.workspace}-data-${data.aws_availability_zones.available.names[count.index]}"
    PROJECT           = var.project
    WORKSPACE         = "${terraform.workspace}"
  }
}
######################

