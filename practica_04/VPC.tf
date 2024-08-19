resource "aws_vpc" "cloud_vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "cloud_vpc"
  }
}

resource "aws_internet_gateway" "cloud_igw" {
  vpc_id = aws_vpc.cloud_vpc.id
  tags = {
    Name = "cloud_igw"
  }
}

resource "aws_subnet" "cloud_subnet" {
  vpc_id                  = aws_vpc.cloud_vpc.id
  cidr_block              = var.cidr_subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "cloud_subnet"
  }
}

resource "aws_route_table" "cloud_rt" {
  vpc_id = aws_vpc.cloud_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud_igw.id
  }
  tags = {
    Name = "cloud_rt"
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
    Name = "cidr_subnet_2"
  }
}

resource "aws_route_table" "cloud_rt_2" {
  vpc_id = aws_vpc.cloud_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud_igw.id
  }
  tags = {
    Name = "cloud_rt_2"
  }
}

resource "aws_route_table_association" "cloud_rt_association_2" {
  subnet_id      = aws_subnet.cidr_subnet_2.id
  route_table_id = aws_route_table.cloud_rt_2.id
}

resource "aws_security_group" "cloud_sg" {
  vpc_id = aws_vpc.cloud_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ingress_cidr_block]
  }
  tags = {
    Name = "cloud_sg"
  }
}

resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.instance_type
  #key_name      = "cloud"
  key_name               = data.aws_key_pair.cloud_key.key_name
  subnet_id              = aws_subnet.cloud_subnet.id
  vpc_security_group_ids = [aws_security_group.cloud_sg.id]
  #### lifecycle en ec2 para que no se destruya cuando se destruya el recurso  cuando se crea otro
  lifecycle {
    create_before_destroy = true # crear nuevo recurso antes de destruir este para algun cambio
    # prevent_destroy = true # no destruir este recurso por ningun motivo, se usa para recursos criticos
    # ignore_changes = [tags] # no hacer cambios en los tags, ami, var, subnet_id.
    # replace_triggered_by = aws_instance.myec2_2 # ignorar el recurso, no se puede modificar
  }
  tags = {
    Name = "myec2"
  }
}

output "ec2_public_ip" {
  value       = aws_instance.myec2.public_ip
  description = "value of ec2 public ip"
}
# output: se usa para mostrar datos de un recurso(ya creado) en la consola 
# para ver los outputs creados en consola: terraform output / terraform output (nombre del output)
# terraform apply --target aws_instance.myec2 / terraform apply --target (nombre del recurso) / terraform destroy --target (nombre del recurso)
# lo anterior es para aplicar cambios a un solo recurso / para borrarlo

########### comandos de terraform ###########
# terraform validate # para validar que todo este bien
# terraform plan # para ver los cambios que se haran
# terraform apply # para aplicar los cambios
# terraform destroy # para borrar los cambios
# terraform fmt para formatear algun archivo .tf
# terraform show para ver todos los recursos en el state 
# terraform show -json para ver el state en formato json
# terraform provider # para ver los proveedores con los que estamos trabajando
# terraform refresh # para buscar cambios
# terraform apply --auto-approve # para aplicar los cambios automaticamente
# terraform apply --replace aws_instance.myec2 --auto-approve # para aplicar los cambios automaticamente y reemplazar el recurso
# terraform graph # para ver el grafico. y para verlo en u  file svg: terraform graph | dot -Tsvg > graph.svg

########### comandos del tfstate ###########
# terraform state list # para ver los recursos guardados
# terraform state rm (nombre del recurso) # para borrar un recurso del state y no los que estan desplegados, asi terraform ya no le da seguimiento.
# terraform state rm aws_instance.myec2 # ejemplo
# terraform state show (nombre del recurso) # para ver el state de un recurso
# terraform state mv (nombre del recurso) (nuevo nombre) # para renombrar un recurso

######### logs en terraform ############
# terraform log (nombre del recurso) # para ver el log de un recurso
# terraform log --type=stdout (nombre del recurso) # para ver el log de un recurso en la consola

# env | grep TF_LOG
# nivel de detalle de los logs 1(minimo detalle) a  5(maximo detalle)
# export TF_LOG=DEBUG # para ver solo el log de terraform # 4
# export TF_LOG=TRACE # para ver todo el log de terraform # 5
# export TF_LOG=INFO # para ver solo el log de terraform # 1
# export TF_LOG=WARN # para ver solo el log de terraform # 2
# export TF_LOG=ERROR # para ver solo el log de terraform # 3

# guardar esos logs en un archivo
# export TF_LOG_PATH=log.txt
#terraform plan 

# para quitarlo
# env | grep TF_LOG
# unset TF_LOG
# unset TF_LOG_PATH

## importar un recurso de aws que no esta hecho por terraform
# resource "aws_instance" "myec2" { asi hay que crearlo
# }
# terraform import aws_instance.myec2 (id del recurso en aws)

#### terraform workspace ####
# terraform workspace list # para ver los workspaces
# terraform workspace new (nombre del workspace) # para crear un workspace
# terraform workspace select (nombre del workspace) # para seleccionar un workspace
# terraform workspace delete (nombre del workspace) # para borrar un workspace
