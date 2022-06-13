## Requirements
#### jq
See [docs](https://stedolan.github.io/jq/).  
`brew install jq`
#### Terraform
See [docs](https://learn.hashicorp.com).  
`brew install terraform`
#### Azure CLI
See [docs](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos).  
`brew install azure-cli`  
Example: `az login`

## Context
The following scripts facilitate the creation of the neccessary resources needed 
to setup remote Terraform state storage using Azure blob storage. The output values 
of the final shell script are needed to configure GitHub Actions and to configure 
the `backend` block in whichever Terraform project you are using this remote storage.

## Usage
_Note: Change the backend_ `key` _to reuse the storage account for multiple TF projects._  

Execute the numbered scripts in order.
1. Run the command `terraform init`, then `terraform apply`.
2. You **must execute the script in the current shell environment**. See example,  
   ```
   $ . ./2.set_backend_storage_env_vars.sh     # identical to "source ./2.set_backend_storage_env_vars.sh"
   ```

### Key points:
* Azure storage accounts require a globally unique name. To learn more about 
troubleshooting storage account names, see 
[Resolve errors for storage account names.](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-storage-account-name)
* Azure Storage blobs are automatically locked before any operation that writes 
state. This pattern prevents concurrent state operations, which can cause 
corruption.
* For more information, see 
[State locking](https://www.terraform.io/docs/state/locking.html) 
in the Terraform documentation.
