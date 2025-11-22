# Chart Museum

This module deploys the chartmuseum to host the helm chart. More info [here](https://chartmuseum.com/).

- [EC2 Microservice](https://github.com/cloudops92/terraform-aws-base-modules/tree/master/src/ec2-microservice)   
  
## Terraform File Info

- `configs`: This directory hold the `docker-compose` files each for service.
- `keypair`: This directory hold the keypair files.

- `acm.tf`: Terraform file to create the AWS ACM resources.
- `alb.tf`: Terraform file to create the AWS ALB, EC2 resources.
- `data.tf`: Terraform data file.
- `chart_museum.tf`: Terraform file that using the terraform module to deploy the service.
- `variables.tf`: Terraform variables file declaring all general variables.
- `service_variables.tf`: Terraform service related variables file declaring all general variables.
- `outputs.tf`: Terraform output file listing general outputs.