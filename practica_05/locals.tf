# locals {
#   suffix = "cloud_practica_05"
# }

locals {
  suffix = "${var.tags_of_vpc["region"]}-${var.tags_of_vpc["Environment"]} "
}

resource "random_string" "sufijo_random" {
  length  = 8
  special = false
  upper   = false
}

locals {
  sufijo_random = "-${var.tags_of_vpc["Environment"]}-${var.tags_of_vpc["region"]}-${random_string.sufijo_random.id}"
}
