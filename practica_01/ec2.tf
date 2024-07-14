
resource "aws_instance" "myec2" {
  count         = 5
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "myec2-${random_string.random[count.index].id}"
  }
}




