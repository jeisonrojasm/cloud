#!/bin/bash
echo "Hola mundo desde la instancia" > ~/saludo.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
