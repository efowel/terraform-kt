variable "env" {
  type        = string
  description = "infrastructure environment"
  default     = "DEV"
}

variable "project" {
  description = "For Metadata Tags"
  type        = string
  default     = "DiditalBank"
}

variable "region" {
  type        = string
  description = "AWS REGION"
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  type        = string
  description = "Short Name for VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR"
}

variable "subnet_public_cidr" {
  type        = list
  description = "Public Subnet CIDR"
}

variable "subnet_private_cidr" {
  type        = list
  description = "Private Subnet CIDR"
}

variable "subnet_data_cidr" {
  type        = list
  description = "Data Subnet CIDR"
}