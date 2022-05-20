#########Variables##########
variable "naming_prefix" {
  type         = string #can be a number,list,boolean,map etc.
  description  = "this is a sample variable"
  #sensitive    = true #for sensitve value {defaults to false}
  default      = "foo"
}

locals {
  prefix = "${var.naming_prefix}-test"
  common_tags = {
      env       = "test"
      project   = "terraform"
      name      = "${var.naming_prefix}-resource"
  }
}

data "external" "myip" {
  program = ["/bin/bash" , "${path.module}/ip.sh"]
}

resource "local_file" "foo" {
    content  = data.external.myip.result["internet_ip"]
    filename = "${path.module}/foo.bar"
}

output "local" {
    value = local.prefix
}

output "common_tags" {
    value = local.common_tags
}