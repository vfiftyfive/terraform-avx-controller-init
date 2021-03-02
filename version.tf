terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.29.0"
    }
    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "2.18.0"
    }
  }
}