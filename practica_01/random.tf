resource "random_string" "random" {
  count   = 5 # para hacer 5 objetos random_string, uno pora cada recurso
  length  = 6
  special = false
  upper   = false
  numeric = false
}
