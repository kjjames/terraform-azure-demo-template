# Terraform on Azure: "Power Hour" Demo
This repo contains the boilerplate code to start a Terraform project on Azure.
It also includes a boilerplate Github actions pipeline to deploy to Azure.  

For more information about options to authenticate Terraform to Azure, see 
[Authenticating using the Azure CLI.](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/azure_cli)

## Requirements
* Set neccessary Azure credentials variables in GitHub Repository Secrets.
* Install Azure CLI tools: `brew install azure-cli`
* Authenticate with Azure: `az login`
* Run Terraform commands: `terraform init` and `terraform apply`
