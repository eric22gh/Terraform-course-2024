variable "tags_of_vpc" {
}

variable "cidr_vpc" {
  description = "value of cidr_vpc"
  type        = string
  sensitive   = false # false por defecto, para ocultar la ip de la cidr
}

variable "ami" {
}

variable "instance_type" {
}

variable "cidr_subnet" {
  type        = string
  description = "value of cidr_subnet"
}

variable "cidr_subnet_2" {
  type        = string
  description = "value of cidr_subnet_private"
}

variable "subnets" {
  type    = list(string)
  default = ["89.207.132.0/25", "89.207.142.0/25"]
}

variable "subnets_private" {
  type = map(string)

  default = {
    subnet1 = "89.207.132.128/25"
    subnet2 = "89.207.142.128/25"
  }

}

variable "ingress_cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
  description = "value of ingress_cidr_block"
}
