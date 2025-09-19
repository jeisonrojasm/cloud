variable "virginia_cidr" {
  description = "CIDR de Virginia VPC"
  type        = string
  sensitive   = true
}

# variable "public_subnet"{
#   description = "CIDR de la subred publica"
#   type        = string
#   sensitive   = true
# }

# variable "private_subnet"{
#   description = "CIDR de la subred privada"
#   type        = string
#   sensitive   = true
# }

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "EC2 instance specifications"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Enable monitoring for EC2 instances"
  type        = number
}

variable "ingress_port_list" {
  description = "List of ingress ports"
  type        = list(number)  
}