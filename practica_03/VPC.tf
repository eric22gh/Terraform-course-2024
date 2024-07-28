
resource "aws_vpc" "cloud_vpc" {
  cidr_block = var.cidr_vpc

  tags = var.tags_of_vpc
}


resource "aws_vpc" "onpremis_vpc" {
  cidr_block = var.cidr_vpc_onpremis

  tags = var.tags_of_onpremis_vpc
}
