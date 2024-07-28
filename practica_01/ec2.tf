
resource "aws_instance" "myec2" {
  count         = 5
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "myec2-${random_string.random[count.index].id}"
  }
}

# terraform apply -var="ami=ami-0b0dcb5067f052a63" -var="instance_type=t2.micro"




