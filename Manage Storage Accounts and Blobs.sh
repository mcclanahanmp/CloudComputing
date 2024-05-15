#!/bin/bash

# Variables
RESOURCE_GROUP="<resource-group-name>"
LOCATION="<location>"
STORAGE_ACCOUNT="<storage-account-name>"
CONTAINER="<container-name>"
FILE_PATH="<file-path>"
BLOB_NAME="<blob-name>"
DOWNLOAD_PATH="<download-path>"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage account
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS

# Get storage account key
STORAGE_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $STORAGE_ACCOUNT --query '[0].value' --output tsv)

# Create container
az storage container create --name $CONTAINER --account-name $STORAGE_ACCOUNT --account-key $STORAGE_KEY

# Upload file to container
az storage blob upload --container-name $CONTAINER --file $FILE_PATH --name $BLOB_NAME --account-name $STORAGE_ACCOUNT --account-key $STORAGE_KEY

# List blobs in container
az storage blob list --container-name $CONTAINER --account-name $STORAGE_ACCOUNT --account-key $STORAGE_KEY --output table

# Download blob from container
az storage blob download --container-name $CONTAINER --name $BLOB_NAME --file $DOWNLOAD_PATH --account-name $STORAGE_ACCOUNT --account-key $STORAGE_KEY

# Delete storage account
az storage account delete --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --yes
