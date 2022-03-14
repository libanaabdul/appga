provider "aws" {
  region = local.region
}

locals {
  region = "us-west-2"
}


terraform {
  backend "s3" {
    bucket     = "statelib"
    key        = "lib/terraform.tfstate"
    region     = "us-west-2"
  }
}