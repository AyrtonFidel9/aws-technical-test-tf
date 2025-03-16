terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
    random = {
      version = "~> 3.7"
    }
  }

  backend "s3" {
    
  }
  
}