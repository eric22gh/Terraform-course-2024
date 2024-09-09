resource "aws_vpc" "cloud_vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "cloud_vpc-${local.suffix}"
  }
}

resource "aws_internet_gateway" "cloud_igw" {
  vpc_id = aws_vpc.cloud_vpc.id
  tags = {
    Name = "cloud_igw-${local.suffix}"
  }
}

resource "aws_subnet" "cloud_subnet" {
  vpc_id                  = aws_vpc.cloud_vpc.id
  cidr_block              = var.cidr_subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "cloud_subnet-${local.suffix}"
  }
}

resource "aws_route_table" "cloud_rt" {
  vpc_id = aws_vpc.cloud_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud_igw.id
  }
  tags = {
    Name = "cloud_rt-${local.suffix}"
  }
}

resource "aws_route_table_association" "cloud_rt_association" {
  subnet_id      = aws_subnet.cloud_subnet.id
  route_table_id = aws_route_table.cloud_rt.id
}

resource "aws_subnet" "cidr_subnet_2" {
  vpc_id                  = aws_vpc.cloud_vpc.id
  cidr_block              = var.cidr_subnet_2
  map_public_ip_on_launch = true
  tags = {
    Name = "cidr_subnet_2-${local.suffix}"
  }
}

resource "aws_route_table" "cloud_rt_2" {
  vpc_id = aws_vpc.cloud_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud_igw.id
  }
  tags = {
    Name = "cloud_rt_2-${local.suffix}"
  }
}

resource "aws_route_table_association" "cloud_rt_association_2" {
  subnet_id      = aws_subnet.cidr_subnet_2.id
  route_table_id = aws_route_table.cloud_rt_2.id
}

resource "aws_security_group" "cloud_sg" {
  vpc_id = aws_vpc.cloud_vpc.id
  dynamic "ingress" {
    for_each = var.ingress_port-list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.ingress_cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ingress_cidr_block]
  }
  tags = {
    Name = "cloud_sg-${local.suffix}"
  }
}

resource "aws_instance" "myec2" {
  count                       = length(var.instance_count) # en una variable de tipo list(string), va contar la cantidad de strings que hay 
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.cloud_key.key_name
  subnet_id                   = aws_subnet.cloud_subnet.id
  vpc_security_group_ids      = [aws_security_group.cloud_sg.id]
  associate_public_ip_address = true
  user_data                   = file("scripts/userdata.sh")
  tags = {
    name = "${var.instance_count[count.index]}-${local.suffix}"
    #Name = var.instance_count[count.index] # para ponerle el nombre a cada ec2
  }
}
# para crear varias ec2 y selecionar cual borrar
# terraform destroy -target aws_instance.myec2[2] se escojes de la lista que tiene el terraform state list

# el for_each sirve para crear multiples recursos, compatile solo con variables set y map
# nota: el count en el terraform state list ve a las ec2 como indices(sin nombtre),
# encambio con for_each se ven las ec2  en el state list como nombres y con el si se pueden borrar desde el codigo.
# es mejor hacerlo con for_each que con count(por el indice se va corriendo)

resource "aws_instance" "myec2_for_each" {
  for_each                    = var.instances_for_each # en una variable de tipo list(string), va contar la cantidad de strings que hay 
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.cloud_key.key_name
  subnet_id                   = aws_subnet.cloud_subnet.id
  vpc_security_group_ids      = [aws_security_group.cloud_sg.id]
  associate_public_ip_address = true
  user_data                   = file("scripts/userdata.sh")
  tags = {
    name = "${each.key}-${local.suffix}"
    #Name = each.value # para ponerle el nombre a cada ec2
  }
}
######### intercambios condicionales em terraform destroy 

resource "aws_instance" "myec2_monitoring" {
  count                       = var.enable_monitoring ? 1 : 0
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.cloud_key.key_name
  subnet_id                   = aws_subnet.cloud_subnet.id
  vpc_security_group_ids      = [aws_security_group.cloud_sg.id]
  associate_public_ip_address = true
  user_data                   = file("scripts/userdata.sh")
  tags = {
    Name = "myec2_monitoring-${local.suffix}"
  }
}

######## locals con los buckets de s3, es muy bueno para los nombres unicos

resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket_ventas-${local.suffix}"
}

resource "aws_s3_bucket" "mybucket2" {
  bucket = "mybucket2_ventas-${local.sufijo_random}"
}
