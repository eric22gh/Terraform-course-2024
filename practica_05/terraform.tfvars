cidr_vpc = "89.207.0.0/18"

tags_of_vpc = {
   Name        = "cloud_vpc"
    Owner       = "Eric Hernandez Edwards"
    Purpose     = "Learning Terraform"
    Environment = "Development"
    IaC         = "Terraform"
    year        = "2024"
    region = "us-east-1"
}

ami = "ami-0ae8f15ae66fe8cda"
instance_type = "t2.micro"

cidr_subnet = "89.207.1.0/24"
cidr_subnet_2 = "89.207.2.0/24"