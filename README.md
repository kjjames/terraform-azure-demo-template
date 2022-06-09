# Terraform on Azure: "Power Hour" Demo
[![Terraform](https://github.com/kjjames/terraform_azure_ph_demo/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/kjjames/terraform_azure_ph_demo/actions/workflows/terraform.yml)  
This repo contains the boilerplate code to start a Terraform project on Azure.
It also includes a boilerplate Github actions pipeline to deploy to Azure.  

For more information about options to authenticate Terraform to Azure, see 
[Authenticating using the Azure CLI.](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/azure_cli)


## Requirements
* Set neccessary Azure credentials variables in GitHub Repository Secrets.
* Install Azure CLI tools: `brew install azure-cli`
* Authenticate with Azure: `az login`
* Run Terraform commands: `terraform init` and `terraform apply`

## Usage
* Initialize remote storage for Terraform state by executing the scripts in the 
  `init` folder in order.
