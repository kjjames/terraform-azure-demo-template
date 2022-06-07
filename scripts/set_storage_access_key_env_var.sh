# Get account key via Azure CLI
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
# Set environment variable to be used by Terraform
export TF_VAR_ARM_ACCESS_KEY=$ACCOUNT_KEY
