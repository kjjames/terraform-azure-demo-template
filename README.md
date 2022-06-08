# terraform_azure_ph_demo
For more information about options to authenticate Terraform to Azure, see 
[Authenticating using the Azure CLI.](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/azure_cli)

## Example Usage
* Install Azure CLI tools `brew install azure-cli`
* Authenticate with Azure `az login`
* Run Terraform commands `terraform init` and `terraform apply`
* Copy the output `STORAGE_ACCOUNT_NAME=<copy_this_value>` and use that value 
  to configure your remote backend storage in your Terraform project  
  **Note: Change the backend key to reuse the storage account for multiple TF projects**
