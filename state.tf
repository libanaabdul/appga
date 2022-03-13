provider "aws" {
  region = local.region
}

locals {
  region = "us-west-2"
}


terraform {
  backend "s3" {
    bucket     = "state-lib"
    key        = "lib/terraform.tfstate"
    region     = "us-west-2"
  }
}