terraform {
  required_version = "> 0.12"

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
    Deployment    = var.deployment
    Repo          = var.repo
    Tool          = var.tool
    ResourceGroup = var.resource_group
    Module        = var.module
  }

  tags = merge(local.default_tags, var.tags)
}
