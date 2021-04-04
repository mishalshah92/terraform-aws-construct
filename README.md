# Terraform AWS Modules

Terraform modules to deploy resources on AWS cloud with its possible configurations.
These modules deploy bunch of resources with all required configurations considering monitoring, availability and reliability.    

- **Terraform version** >= `0.14`

## Base Modules

- [terraform-aws-base-modules](https://github.com/cloudops92/terraform-aws-base-modules)

## Modules

- [client-vpn-endpoint](src/client-vpn-endpoint)
- [db-subnet-groups](src/db-subnet-groups)
- [docdb](src/docdb)
- [ec2-launch-template](src/ec2-launch-template)  
- [eks-master](src/eks-master)    
- [eks-node-group](src/eks-node-group)
- [iam](src/iam)
- [iam_membership](src/iam_membership)
- [iam_users](src/iam_users)   
- [rds-postgresql-db](src/rds-postgresql-db)   
- [redis-elasticache](src/redis-elasticache)
- [resource-group](src/resource-group)    
- [vpc](src/vpc)    
- [vpc-peering](src/vpc-peering)     
  
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