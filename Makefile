REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
COMMIT:=$(MODULE)_$(DEPLOYMENT)_$(DATE)_$(REV)

# Defaults
ACCOUNT:=NO_ACCOUNT
CUSTOMER:=NO_CUSTOMER
ENV:=NO_ENV
REGION:=NO_REGION
MODULE:=NO_MODULE
DEPLOYMENT:=NO_DEPLOYMENT
RG:=$(RG)

REPO:=https://github.com/cloudops92/terraform-aws-deployments

# Terraform Var files
MODULE_PATH:=terraform/$(MODULE)
MODULE_VAR_FILE:=values/$(ACCOUNT)/$(RG)/$(MODULE)/$(REGION)/$(DEPLOYMENT).tfvars

# Terraform backend configs
TF_BACKEND_BUCKET:=terraform-tfstate
TF_BACKEND_DB:=terraform-tfstate
TF_BACKEND_REGION:=ap-south-1
TF_BACKEND_ENCRYPT:=true
TF_BACKEND_STATE_PATH:=terraform-aws-deploy/$(ACCOUNT)/$(RG)/$(MODULE)/$(REGION)/$(DEPLOYMENT)/terraform.tfstate

TF_PLAN_FILE:=$(ACCOUNT)_$(RG)_$(MODULE)_$(REGION)_$(DEPLOYMENT)_$(REV)

install:
	tfenv install

init: clean
	terraform init \
		-backend-config='bucket=$(TF_BACKEND_BUCKET)' \
		-backend-config='dynamodb_table=$(TF_BACKEND_DB)' \
		-backend-config='region=$(TF_BACKEND_REGION)' \
		-backend-config='key=$(TF_BACKEND_STATE_PATH)' \
		-backend-config='encrypt=$(TF_BACKEND_ENCRYPT)' $(MODULE_PATH)

upgrade: clean
	terraform init \
		-backend-config='bucket=$(TF_BACKEND_BUCKET)' \
		-backend-config='dynamodb_table=$(TF_BACKEND_DB)' \
        -backend-config='region=$(TF_BACKEND_REGION)' \
        -backend-config='key=$(TF_BACKEND_STATE_PATH)' \
        -backend-config='encrypt=$(TF_BACKEND_ENCRYPT)' -upgrade $(MODULE_PATH)

validate:
	terraform validate $(MODULE_PATH)

plan: validate
	terraform plan -state=$(TF_BACKEND_STATE_PATH) \
		-var 'resource_group=$(RG)' \
		-var 'region=$(REGION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' \
		-out=$(TF_PLAN_FILE).tfplan $(MODULE_PATH)

plan-destroy: validate
	terraform plan -destroy -state=$(TF_BACKEND_STATE_PATH) \
		-var 'resource_group=$(RG)' \
		-var 'region=$(REGION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' \
		-out=$(TF_PLAN_FILE).tfplan $(MODULE_PATH)

apply: validate
	terraform apply -state=$(TF_BACKEND_STATE_PATH) \
		-var 'resource_group=$(RG)' \
		-var 'region=$(REGION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' $(MODULE_PATH)

apply-plan:
	terraform apply -state=$(TF_BACKEND_STATE_PATH) $(TF_PLAN_FILE).tfplan

destroy: validate
	terraform destroy -state=$(TF_BACKEND_STATE_PATH) \
		-var 'resource_group=$(RG)' \
		-var 'region=$(REGION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' \
		$(MODULE_PATH)

clean:
	rm -rf .terraform/ || true
	rm *.tfplan  || true