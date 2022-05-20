#######VARS#######
variable "project"         { description = "For Metadata Tags" }
variable "name"            { description = "Short Name for VPC" }
variable "cidr_block"      { description = "VPC CIDR" }
#variable "nat_subnet_id"  { description = "Sunbet for NAT" }

######OUTPUT######
output "vpc_id"            {  value = aws_vpc.main.id }
output "vpc_cidr"          {  value = aws_vpc.main.cidr_block }
output "vpc_igw_id"        {  value = aws_internet_gateway.vpc_igw.id }
#output "nat_ip"           {  value = aws_eip.nat_gateway.public_ip }

##Creates VPC
resource "aws_vpc" "main" {
  cidr_block            = var.cidr_block
  instance_tenancy      = "default"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name                = "${terraform.workspace}-${var.name}-vpc"
    PROJECT             = var.project
    WORKSPACE           = "${terraform.workspace}"
  }
}

##Creates Internet Gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id                =  aws_vpc.main.id
  tags = {
    Name                = "${terraform.workspace}-${var.name}-igw"
    PROJECT             = var.project
    WORKSPACE           = "${terraform.workspace}"
  }
}

##Creates NAT Gateway
#resource "aws_eip" "nat_gateway" {
#  vpc = true
#}
#resource "aws_nat_gateway" "nat_gateway" {
#  allocation_id         = aws_eip.nat_gateway.id
#  subnet_id             = var.nat_subnet_id
#  tags = {
#    Name                = "${terraform.workspace}-${var.name}-nat"
#    PROJECT             = var.project
#    WORKSPACE           = "${terraform.workspace}"
#  }
#}