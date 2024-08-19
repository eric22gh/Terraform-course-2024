cidr_vpc = "89.207.0.0/18"

tags_of_vpc = {
   Name        = "cloud_vpc"
    Owner       = "Eric Hernandez Edwards"
    Purpose     = "Learning Terraform"
    Environment = "Development"
    IaC         = "Terraform"
    year        = "2024"
}

ami = "ami-0f65f2a98bbe4f31f"
instance_type = "t2.micro"

cidr_subnet = "89.207.1.0/24"
cidr_subnet_2 = "89.207.2.0/24"