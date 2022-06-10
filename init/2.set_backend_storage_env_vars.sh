# Set shell variables from Terraform output
terraform output -json | jq -r \
    '@sh "AZURE_AD_CLIENT_ID=\(.client_id.value)\nAZURE_AD_CLIENT_SECRET=\(.client_secret.value)\nAZURE_AD_TENANT_ID=\(.tenant_id.value)\nAZURE_SUBSCRIPTION_ID=\(.subscription_id.value)\nSTORAGE_ACCOUNT_NAME=\(.storage_account_name.value)\nRESOURCE_GROUP_NAME=\(.resource_group_name.value)"' >temp.sh
source temp.sh
rm temp.sh
# Set access key to be used by Terraform
# https://www.terraform.io/language/settings/backends/azurerm
echo "Add these key/value pairs to GitHub Action Secrets to authenticate pipeline:"
echo "AZURE_AD_CLIENT_ID=$AZURE_AD_CLIENT_ID"
echo "AZURE_AD_CLIENT_SECRET=$AZURE_AD_CLIENT_SECRET"
echo "AZURE_AD_TENANT_ID=$AZURE_AD_TENANT_ID"
echo "AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID"
echo ""
echo "Copy the unique storage account name into your root Terraform module's backend:"
echo "STORAGE_ACCOUNT_NAME: $STORAGE_ACCOUNT_NAME"
echo ""
# Get account key via Azure CLI
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY
echo "ARM_ACCESS_KEY environment variable has been set."
echo "Terraform can now be authenticated via the remote storage account access key!"
