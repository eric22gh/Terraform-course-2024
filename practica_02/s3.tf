resource "aws_s3_bucket" "cloud" {
  count  = 2
  bucket = "cloud-${random_string.random[count.index].id}"
  tags   = var.tags_of_s3

}

###### guradar el plan en un archivo .plan
# terraform plan --out s3.plan
# terraform apply s3.plan
# terraform destroy s3.plan
# terraform fmt para formatear algun archivo .tf


