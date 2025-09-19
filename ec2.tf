variable "instancias" {
  description = "Nombre de las instancias"
  type        = list(string)
  default     = ["apache"]
}

resource "aws_instance" "public_instance" {
  for_each      = toset(var.instancias)
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  user_data     = file("./user-data.sh")

  vpc_security_group_ids = [
    aws_security_group.public_instance_sg.id
  ]

  tags = {
    "Name" = "${each.value}-${local.suffix}"
  }
}

resource "aws_instance" "monitoring_instance" {
  count         = var.enable_monitoring == 5 ? 1 : 0
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  user_data     = file("./user-data.sh")

  vpc_security_group_ids = [
    aws_security_group.public_instance_sg.id
  ]

  tags = {
    "Name" = "Monitoreo-${local.suffix}"
  }
}
