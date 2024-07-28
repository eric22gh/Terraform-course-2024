resource "random_string" "random" {
  count   = 2 # uno para cada recurso
  length  = 6
  special = false
  upper   = false
  numeric = false
}
