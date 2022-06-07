## Usage
Run the command `terraform init`, then `terraform apply` to configure the Azure 
storage account and container.

### Key points:
* Public access is allowed to Azure storage account for storing Terraform state.
* Azure storage accounts require a globally unique name. To learn more about 
troubleshooting storage account names, see 
[Resolve errors for storage account names.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-storage-account-name)
