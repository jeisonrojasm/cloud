resource "aws_vpc" "vpc_virginia" {
  provider   = aws.virginia
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "VPC-Virginia-${local.suffix}"
  }
}

resource "aws_subnet" "public_subnet" {
  provider                = aws.virginia
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public-Subnet-${local.suffix}"
  }
}

resource "aws_subnet" "private_subnet" {
  provider   = aws.virginia
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  depends_on = [
    aws_subnet.public_subnet
  ]
  tags = {
    "Name" = "Private-Subnet-${local.suffix}"
  }
}

resource "aws_internet_gateway" "igw" {
  provider = aws.virginia
  vpc_id   = aws_vpc.vpc_virginia.id

  tags = {
    "Name" = "Internet-Gateway VPC Virgnia-${local.suffix}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "Public-Route-Table-${local.suffix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "public_instance_sg" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  # ingress {
  #   description = "SSH over Internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "HTTP over Internet"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "HTTPS over Internet"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  dynamic "ingress" {
    for_each = var.ingress_port_list

    content {
      from_port   = ingress.value # Este ingress.value es el valor actual del bucle
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "Public Instance SG-${local.suffix}"
  }
}
