# Set environment variables from Terraform output
terraform output -json | jq -r \
    '@sh "export RESOURCE_GROUP_NAME=\(.RESOURCE_GROUP_NAME.value)\nexport STORAGE_ACCOUNT_NAME=\(.STORAGE_ACCOUNT_NAME.value)\nexport STORAGE_CONTAINER_NAME=\(.STORAGE_CONTAINER_NAME.value)"' \
    >env.sh
source env.sh
rm env.sh
# Get account key via Azure CLI
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
# Set access key to be used by Terraform
# https://www.terraform.io/language/settings/backends/azurerm
export ARM_ACCESS_KEY=$ACCOUNT_KEY
echo "RESOURCE_GROUP_NAME=$RESOURCE_GROUP_NAME"
echo "STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME"
echo "STORAGE_CONTAINER_NAME=$STORAGE_CONTAINER_NAME"
echo "ARM_ACCESS_KEY=$ARM_ACCESS_KEY"
