
variable "tags_of_s3" {
  type = map(any)
  default = {
    Name        = "cloud-bucket"
    Owner       = "Eric Hernandez Edwards"
    Purpose     = "Learning Terraform"
    Environment = "Development"
    IaC         = "Terraform"
    year        = "2024"
  }
}


