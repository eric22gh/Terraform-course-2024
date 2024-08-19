terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = var.tags_of_vpc # para que todos los recursos tengan el mismo tag y asi ponerle tags = nombre individual a cada recurso
  }
}

# cp -r practica_02 practica_03
# output: se usa para mostrar datos de un recurso(ya creado) en la consola 
# el terraform.tfstate tiene datos sencibles
# less terraform.tfstate
# less terraform.tfstate.backup
# tfstate de manera remota(no hay que subirlo a un repositorio publico es mejor subirlo en un bucket cifrado de s3)
# sirve para cuando hay varias personas en el mismo proyecto


