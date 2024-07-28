
resource "aws_vpc" "cloud_vpc" {
  cidr_block = var.cidr_vpc

  tags = var.tags_of_vpc
}


resource "aws_vpc" "onpremis_vpc" {
  cidr_block = var.cidr_vpc_onpremis

  tags = var.tags_of_onpremis_vpc

  provider = aws.onpremis # hacer referencia al provider de onpremis y se despliige en el, ya que esta en otra region
}

# output: se usa para mostrar datos de un recurso(ya creado) en la consola 
resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "cloud"
  tags = {
    Name = "myec2"
  }
}

output "ec2_public_ip" {
  value       = aws_instance.myec2.public_ip
  description = "value of ec2 public ip"
}
