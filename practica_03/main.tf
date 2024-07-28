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
}

provider "aws" {
  alias  = "onpremis"
  region = "us-east-2"
}

# cp -r practica_02 practica_03
# output: se usa para mostrar datos de un recurso(ya creado) en la consola 
