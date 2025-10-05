#AWS Virtual Private Cloud (VPC)
resource "aws_vpc" "vpc_paris" {
  cidr_block = var.paris_cidr
  tags = {
    Name = "vpc_paris-${local.sufix}"
  }
}

#Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_paris.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "AWS_PUBLIC_SUBNET-${local.sufix}"
  }
}

#Private Subnet
resource "aws_subnet" "private_subnet"{
  vpc_id = aws_vpc.vpc_paris.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "AWS_PRIVATE_SUBNET-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]
}


#Internet Gateway IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_paris.id

  tags = {
    Name = "igw_vpc_Paris-${local.sufix}"
  }
}

#Routing Table CRT
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_paris.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_crt-${local.sufix}"
  }
}

#Routing Table Association
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

#Security groups config
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH Inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_paris.id
  tags = {
    Name = "Public_Instance_SG-${local.sufix}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_rule" {
  security_group_id = aws_security_group.sg_public_instance.id
  description = "SSH Over Internet"

  cidr_ipv4   = var.sg_ingress_cidr
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "egress_all" {
  security_group_id = aws_security_group.sg_public_instance.id
  description = "Egress all internet traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}