variable "paris_cidr" {
  description   = "CIDR de la VPC de Paris"
  type          = string
  sensitive     = false
}

# variable "public_subnet" {
#   description = "CIDR public Subnet"
#   type = string
# }

# variable "private_subnet" {
#   description = "CIDR private Subnet"
#   type = string
# }

variable "subnets" {
  description = "Lista de subnets"
  type = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type = map(string)
}

variable "sg_ingress_cidr" {
  description = "cidr for public ingress traffic"
  type = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type = map(string)
}

variable "access_key" {
  
}

variable "secret_key" {
  
}