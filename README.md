# Terraform AWS Construct

This repo is a collection of opinionated, ready-to-deploy AWS infrastructure compositions built entirely 
using vanilla Terraform modules. This repository provides higher-level, production-grade constructs that 
assemble reusable modules into complete, deployable architectures. It acts as the integration layer — 
consuming modules from upstream Terraform module repositories and composing them into practical end-to-end 
solutions.

With that it provide structure to set and maintain Terraform values for multiple accounts/regions/modules.
With this structure we can deploy same resource multiple time acros any account/region each for resource-group 
without any external framework. 

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

- [chartmuseum](terraform/chartmuseum)
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
Values directory store the terraform values in path `{account} -> {resource-group} -> {module} -> {aws_region}  -> {profile}.tfvars`

```
├───terraform
│   ├───client-vpn-endpoint
│   │   └───.terraform
│   │       └───modules
│   ├───db-subnet-groups
│   ├───sso
│   │   └───resources
│   ├───vpc
│   ├───vpc-devops
│   └───vpc-peering
└───values
    └───account_name
        └───resource_group
            └───module
                └───us-east-1
```

## Terraform state info

- S3_Bucket: `terraform-tfstate`
- DynamoDB_Table: `terraform-tfstate`
- AWS_REGION: `ap-south-1`
- ENCRYPT: `true`
- STATE_PATH: `terraform-aws-deploy/$(ACCOUNT)/$(RESOURCE_GROUP)/$(MODULE)/$(REGION)/$(PROFILE)/terraform.tfstate`


## Make Targets

With each `make` target below input is mandatory.

- `ACCOUNT`: Name of the aws account.
- `CUSTOMER`: Name of the customer.
- `ENV`: Environment to deploy.
- `REGION`: AWS region.
- `MODULE`: Name of the module to deploy.
- `DEPLOYMENT`: Name of the profile/configurations to deploy.
- `RG`: Name of the resource group to deploy.


Make sure you have that environment following directory structure.

### Targets

- `$ make init`

  Running `terraform init...` to initialize terraform.

- `$ make validate`

  Running `terraform validate...` to validate the Terraform syntax.

- `$ make plan`

  Running `terraform plan...` to print the plan.

- `$ make plan-destroy`

  Running `terraform plan -destroy...` to print the plan for removing resources.

- `$ make apply`

  Running `terraform apply...` to execute deployment.

- `$ make apply-plan`

  Running `terraform apply...` with plan.

- `$ make destroy`

  Running `terraform destroy` to destroy the deployment.

### Maintainer

Maintained by Mishal Shah
📧 mishalshah92@gmail.com

### Releases

Click [here](RELEASES.md) to view Releases!!!