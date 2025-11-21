# Terraform AWS Construct

This repo is a collection of opinionated, ready-to-deploy AWS infrastructure compositions built entirely 
using vanilla Terraform modules. This repository provides higher-level, production-grade constructs that 
assemble reusable modules into complete, deployable architectures. It acts as the integration layer 
— consuming modules from upstream Terraform module repositories and composing them into practical end-to-end 
solutions.

**Key features:**
- Composes AWS architectures using standard Terraform modules.
- Provides reusable, versioned infrastructure constructs.
- Ensures consistent patterns across environments.
- Simplifies deployment of complex AWS setups with minimal configuration.
- Use this repo when you want modular, maintainable, and production-ready AWS infrastructure built on top of Terraform best practices.

**Terraform version** >= `0.14`

## AWS Core Modules

- [terraform-aws-core-modules](https://github.com/mishalshah92/terraform-aws-core-modules)

## Modules

- [client-vpn-endpoint](terraform/client-vpn-endpoint)
- [db-subnet-groups](terraform/db-subnet-groups)
- [docdb](terraform/docdb)
- [ec2-launch-template](terraform/ec2-launch-template)  
- [eks-master](terraform/eks-master)    
- [eks-node-group](terraform/eks-node-group)
- [iam](terraform/iam)
- [iam-groups](terraform/iam-groups)
- [iam-policies](terraform/iam-policies)
- [iam-roles](terraform/iam-roles)   
- [iam-users](terraform/iam-users)
- [rds-postgresql-db](terraform/rds-postgresql-db)   
- [redis-elasticache](terraform/redis-elasticache)
- [resource-group](terraform/resource-group)
- [sso](terraform/sso)
- [vpc](terraform/vpc)
- [vpc-devops](terraform/vpc-devops)
- [vpc-peering](terraform/vpc-peering)     
  
## Directory structure

Terraform directory holds the various modules code.

```
terraform
|-- iam_membership
|   |-- data.tf
|   |-- groups.tf
|   |-- main.tf
|   |-- roles.tf
|   `-- variables.tf
`-- iam_users
    |-- data.tf
    |-- main.tf
    |-- policies
    |   `-- user_default_policy.json
    |-- users.tf
    `-- variables.tf
```

### Overview

- **Maintainer**: mishalshah92@gmail.com

## Releases

Click [here](RELEASES.md) to view Releases!!!