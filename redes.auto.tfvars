virginia_cidr = "10.0.0.0/16"

# public_subnet  = "10.0.1.0/24"
# private_subnet = "10.0.2.0/24"
subnets = ["10.0.1.0/24", "10.0.2.0/24"]
tags = {
  "env"   = "Dev"
  "owner" = "Jeison"
  "cloud" = "AWS"
  "IAC"   = "Terraform"
  "IAC version" : "1.13.2"
  "project" = "serverus"
  "region"  = "virginia"
}
sg_ingress_cidr = "0.0.0.0/0"
ec2_specs = {
  ami           = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"
}
