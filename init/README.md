## Requirements
You must have `jq` installed. Example `brew install jq`.  
And you must autheticate via the Azure CLI. Example `az login`.

## Usage
Execute the numbered scripts in order.

1. Run the command `terraform init`, then `terraform apply` to configure the Azure 
   storage account and container.
2. Execute the script in the current shell environment to properly set env vars   
   Example:  
   ```bash
   . ./2.set_backend_storage_env_vars.sh     # identical to "source ./2.set_backend_storage_env_vars.sh"
   ```
3. Copy the output `STORAGE_ACCOUNT_NAME=<copy_this_value>` and use that value 
   to configure your remote backend storage in your Terraform project  
   **Note: Change the backend `key` to reuse the storage account for multiple TF projects**

### Key points:
* Public access is allowed to Azure storage account for storing Terraform state.
* Azure storage accounts require a globally unique name. To learn more about 
troubleshooting storage account names, see 
[Resolve errors for storage account names.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-storage-account-name)
* Azure Storage blobs are automatically locked before any operation that writes 
state. This pattern prevents concurrent state operations, which can cause 
corruption.
* For more information, see 
[State locking](https://www.terraform.io/docs/state/locking.html) 
in the Terraform documentation.
