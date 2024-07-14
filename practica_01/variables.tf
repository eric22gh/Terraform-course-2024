
variable "ami" {
  type    = string
  default = "ami-0b0dcb5067f052a63"

}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tags_of_myec2" {
  type = map(any)
  default = {
    Name        = "myec2"
    Owner       = "Eric Hernandez Edwards"
    Purpose     = "Learning Terraform"
    Environment = "Development"
    IaC         = "Terraform"
    year        = "2024"
  }
}


