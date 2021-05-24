#Declaration
variable "vpc_name" {}
variable "cidr_value" {}
variable "public_subnet_cidr" {}
data "aws_availability_zones" "azs" {}

provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "vpc" {
  cidr_block  = var.cidr_value

  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_subnet" "public-subnet" {
  count = "${length(data.aws_availability_zones.azs.names)}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(var.public_subnet_cidr,count.index)}"
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"

  tags = {
    "Name" = "Har Subnet ${count.index}"
  }
}














# module "har_webserver" {
#   source         = "./modulesOuterFolder/webserver"
#   vpc_id         = aws_vpc.main.id
#   cidr_block     = "10.0.0.0/24"
#   webserver_name = "har"
#   ami            = "ami-05d72852800cbf29e"
#   instance_type  = "t2.micro"
# }




# resource "aws_instance" "demoinstance" {
#   ami               = "ami-05d72852800cbf29e"
#   instance_type     = "t2.micro"
#   availability_zone = "us-east-2b"
#   security_groups   = [aws_security_group.secure.name]
#   key_name          = "demoUSEast2"
#   user_data         = <<-EOF
#                 #!/bin/bash
#                 yum install httpd -y
#                 service httpd start
#                 chkconfig httpd on
#                 mkdir /var/www/html
#                 echo 'Hey!! This is done using Terraform!' > /var/www/html/index.html
#             EOF

#   tags = {
#     Name = "demoinstance"
#   }
# }



#variable "location" {}
#variable "resgrp_name" {}


#variable "subnet_hub" {}
#variable "subnet_hub_name" {}
#variable "subnet_spoke1" {}
#variable "subnet_spoke1_name" {}
#variable "vpcgw_name" {}
#variable "pubip_name" {}
//variable "env" {}
