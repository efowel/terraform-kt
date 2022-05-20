bucket           = "dev-justin-terraform-test"
key              = "resources/DEV/infra.tfstate"
region           = "ap-southeast-1"

#dynamodb_table  = "terraform-aop-state-prod" #for statelocking
#role_arn        = "arn:aws:iam::XXX:role/terraform-role" #for CICD