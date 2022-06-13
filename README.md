# Terraform on Azure: "Power Hour" Demo
[![Terraform](https://github.com/kjjames/terraform-azure-demo-template/actions/workflows/terraform.yml/badge.svg)](https://github.com/kjjames/terraform-azure-demo-template/actions/workflows/terraform.yml)  
This repo contains the boilerplate code to start a Terraform project on Azure.
It also includes a boilerplate Github actions pipeline to deploy to Azure.  

For more information about options to authenticate Terraform to Azure, see 
[Authenticating using the Azure CLI.](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/azure_cli)

## Usage
Initialize remote storage for Terraform state by executing the scripts in the 
`init` folder. Follow the instructions in the README.

## Requirements
* The following GitHub Action repository secrets are required:  
  `AZURE_AD_CLIENT_ID`, `AZURE_AD_CLIENT_SECRET`, `AZURE_AD_TENANT_ID` and `AZURE_SUBSCRIPTION_ID`.

