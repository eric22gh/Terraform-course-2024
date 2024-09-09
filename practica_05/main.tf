terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
      # provider ramdom necesario para crear nombres con varios caracteres
      # muy bueno para los buckets de s3 o poner un tag al nombre de los servicios
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

