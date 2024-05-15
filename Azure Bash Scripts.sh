#-----------------------------
# Azure CLI Scripts, Bash(sh)
#-----------------------------

# Description: These Bash scripts cover a wide range of common administrative tasks in 
# Azure and should be useful for day-to-day operations.

# List all resource groups

az group list --output table

# Create a resource group

az group create --name MyResourceGroup --location eastus

# List all VMs in a resource group

az vm list --resource-group MyResourceGroup --output table

# Create a VM

az vm create --resource-group MyResourceGroup --name MyVM --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

# Start a VM

az vm start --resource-group MyResourceGroup --name MyVM

# Stop a VM

az vm stop --resource-group MyResourceGroup --name MyVM

# Delete a VM

az vm delete --resource-group MyResourceGroup --name MyVM --yes

# List all storage accounts

az storage account list --output table

# Create a storage account

az storage account create --name mystorageaccount --resource-group MyResourceGroup --location eastus --sku Standard_LRS

# List all SQL databases in a resource group

az sql db list --resource-group MyResourceGroup --output table

# Create a SQL database

az sql db create --resource-group MyResourceGroup --server myserver --name mydatabase --service-objective S0

# Create a network security group

az network nsg create --resource-group MyResourceGroup --name MyNSG

# Add a rule to a network security group

az network nsg rule create --resource-group MyResourceGroup --nsg-name MyNSG --name MyRule --priority 100 --destination-port-ranges 80 --protocol Tcp --access Allow

# List all Azure subscriptions

az account list --output table

# Set the active subscription

az account set --subscription "My Subscription Name"

# List all available VM sizes in a region

az vm list-sizes --location eastus --output table

# Create a virtual network

az network vnet create --name MyVnet --resource-group MyResourceGroup --subnet-name MySubnet

# List all public IP addresses

az network public-ip list --output table

# Create a public IP address

az network public-ip create --resource-group MyResourceGroup --name MyPublicIP

# List all managed disks

az disk list --output table

#----------------------------
# Advanced Azure CLI Scripts
#----------------------------

# Resize a VM

az vm resize --resource-group MyResourceGroup --name MyVM --size Standard_DS3_v2

# Attach a new data disk to a VM

az vm disk attach --resource-group MyResourceGroup --vm-name MyVM --disk MyDisk --new --size-gb 128

# Create an Azure AD application and service principal

az ad sp create-for-rbac --name "MyApp" --role contributor --scopes /subscriptions/<subscription-id>/resourceGroups/MyResourceGroup

# Create a load balancer

az network lb create --resource-group MyResourceGroup --name MyLoadBalancer --sku Basic --frontend-ip-name MyFrontEnd --backend-pool-name MyBackEndPool

# Configure autoscaling for a VM scale set

az monitor autoscale create --resource-group MyResourceGroup --resource MyScaleSet --resource-type Microsoft.Compute/virtualMachineScaleSets --name MyAutoscale --min-count 1 --max-count 5 --count 3

# Backup a VM

az backup protection enable-for-vm --resource-group MyResourceGroup --vault-name MyRecoveryServicesVault --vm MyVM --policy-name DefaultPolicy

# Restore a VM from a backup

az backup restore restore-disks --resource-group MyResourceGroup --vault-name MyRecoveryServicesVault --container-name MyContainer --item-name MyVM --restore-to-staging-storage-account MyStorageAccount

# Create a virtual network peering between two VNets

az network vnet peering create --name MyVnetPeering --resource-group MyResourceGroup --vnet-name MyVnet1 --remote-vnet /subscriptions/<subscription-id>/resourceGroups/MyResourceGroup/providers/Microsoft.Network/virtualNetworks/MyVnet2 --allow-vnet-access

# Deploy a resource template

az deployment group create --resource-group MyResourceGroup --template-file azuredeploy.json --parameters azuredeploy.parameters.json

# Configure a network security group to allow traffic from a specific IP

az network nsg rule create --resource-group MyResourceGroup --nsg-name MyNSG --name AllowSpecificIP --priority 100 --source-address-prefixes 203.0.113.0/24 --source-port-ranges "*" --destination-address-prefixes "*" --destination-port-ranges 80 --access Allow --protocol Tcp --direction Inbound
