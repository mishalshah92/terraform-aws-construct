# Terraform AWS Modules

Terraform modules to deploy resources on AWS cloud with its possible configurations.
These modules deploy bunch of resources with all required configurations considering monitoring, availability and reliability.    

- **Terraform version** >= `0.14`

## Base Modules

- [terraform-aws-base-modules](https://github.com/cloudops92/terraform-aws-base-modules)

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

Terraform directory hold the various modules code.

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

- **Maintainer**: mishalshah1992@gmail.com

## Releases

Click [here](RELEASES.md) to view Releases!!!