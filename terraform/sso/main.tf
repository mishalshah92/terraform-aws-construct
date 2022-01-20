terraform {
  required_version = "> 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }

  backend "s3" {
    encrypt = true
  }
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

provider "aws" {
  region = var.region
}