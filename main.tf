provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_caller_identity" "default" {
}

data "aws_region" "default" {
}

data "aws_partition" "default" {
}

data "aws_subnet" "default" {
  id = var.subnet
  filter {
    name = "my-sub-pub1"
  }
}
output "region" {
  value = data.aws_region.default.name
}