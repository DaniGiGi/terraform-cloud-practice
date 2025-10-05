paris_cidr  = "10.10.0.0/16"

subnets = ["10.10.0.0/24","10.10.1.0/24"]

tags = {
    "name"  = "prueba"
    "env"   = "PROD"
    "Owner" = "Daniel Gomez"
    "IAC"   = "Terraform"
    "IAC_Version" = "4.43.0"
    "project" = "cerberus"
    "region" = "paris"
  } 

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami" = "ami-03601e822a943105f"
  "instance_type" = "t3.micro"
}