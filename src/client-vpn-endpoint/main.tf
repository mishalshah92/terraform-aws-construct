terraform {
  required_version = "> 0.13"

  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

locals {
  default_tags = {
    Customer      = var.customer
    Owner         = var.owner
    Env           = var.env
    Email         = var.email
    Repo          = var.repo
    Tool          = var.tool
    ResourceGroup = var.resource_group
    Deployment    = var.deployment
    Module        = var.module
  }

  tags = merge(local.default_tags, var.tags)
}
