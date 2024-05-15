#------------------------------
# Azure PowerShell(PS) Scripts
#------------------------------

# Description: These PS scripts cover a wide range of common administrative tasks in 
# Azure and should be useful for day-to-day operations.

# List all resource groups

Get-AzResourceGroup

# Create a resource group

New-AzResourceGroup -Name "MyResourceGroup" -Location "EastUS"

# List all VMs in a resource group

Get-AzVM -ResourceGroupName "MyResourceGroup"

# Create a VM

New-AzVm -ResourceGroupName "MyResourceGroup" -Name "MyVM" -Location "EastUS" -VirtualNetworkName "MyVnet" -SubnetName "MySubnet" -SecurityGroupName "MyNSG" -PublicIpAddressName "MyPublicIP"

# Start a VM

Start-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"

# Stop a VM

Stop-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"

# Delete a VM

Remove-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"

# List all storage accounts

Get-AzStorageAccount

# Create a storage account

New-AzStorageAccount -ResourceGroupName "MyResourceGroup" -AccountName "mystorageaccount" -Location "EastUS" -SkuName "Standard_LRS"

# List all SQL databases in a resource group

Get-AzSqlDatabase -ResourceGroupName "MyResourceGroup"

# Create a SQL database

New-AzSqlDatabase -ResourceGroupName "MyResourceGroup" -ServerName "myserver" -DatabaseName "mydatabase" -Edition "Standard" -RequestedServiceObjectiveName "S0"

# Create a network security group

New-AzNetworkSecurityGroup -ResourceGroupName "MyResourceGroup" -Location "EastUS" -Name "MyNSG"

# Add a rule to a network security group

$rule = New-AzNetworkSecurityRuleConfig -Name "MyRule" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80 -Access "Allow"
$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName "MyResourceGroup" -Name "MyNSG"
$nsg.SecurityRules.Add($rule)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg

# List all Azure subscriptions

Get-AzSubscription

# Set the active subscription

Set-AzContext -SubscriptionName "My Subscription Name"

# List all available VM sizes in a region

Get-AzVMSize -Location "EastUS"

# Create a virtual network

$subnet = New-AzVirtualNetworkSubnetConfig -Name "MySubnet" -AddressPrefix "10.0.0.0/24"
New-AzVirtualNetwork -ResourceGroupName "MyResourceGroup" -Location "EastUS" -Name "MyVnet" -AddressPrefix "10.0.0.0/16" -Subnet $subnet

# List all public IP addresses

Get-AzPublicIpAddress

# Create a public IP address

New-AzPublicIpAddress -ResourceGroupName "MyResourceGroup" -Name "MyPublicIP" -Location "EastUS" -AllocationMethod "Dynamic"

# List all managed disks

Get-AzDisk

#-----------------------------
# Advanced PowerShell Scripts
#-----------------------------

# Resize a VM

Resize-AzVM -ResourceGroupName "MyResourceGroup" -VMName "MyVM" -Size "Standard_DS3_v2"

# Attach a new data disk to a VM

$vm = Get-AzVM -ResourceGroupName "MyResourceGroup" -VMName "MyVM"
$diskConfig = New-AzDiskConfig -Location $vm.Location -CreateOption Empty -DiskSizeGB 128
$disk = New-AzDisk -ResourceGroupName "MyResourceGroup" -DiskName "MyDisk" -Disk $diskConfig
Add-AzVMDataDisk -VM $vm -Name "MyDisk" -CreateOption Attach -ManagedDiskId $disk.Id
Update-AzVM -ResourceGroupName "MyResourceGroup" -VM $vm

# Create an Azure AD application and service principal

$sp = New-AzADServicePrincipal -DisplayName "MyApp"
New-AzRoleAssignment -RoleDefinitionName "Contributor" -ServicePrincipalName $sp.ApplicationId -Scope "/subscriptions/<subscription-id>/resourceGroups/MyResourceGroup"

# Create a load balancer

$frontendIP = New-AzLoadBalancerFrontendIpConfig -Name "MyFrontEnd" -PublicIpAddress (New-AzPublicIpAddress -ResourceGroupName "MyResourceGroup" -Name "MyPublicIP" -AllocationMethod Dynamic)
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "MyBackEndPool"
New-AzLoadBalancer -ResourceGroupName "MyResourceGroup" -Name "MyLoadBalancer" -Location "EastUS" -FrontendIpConfiguration $frontendIP -BackendAddressPool $backendPool -Sku "Basic"

# Configure autoscaling for a VM scale set

$scaleSet = Get-AzVmss -ResourceGroupName "MyResourceGroup" -VMScaleSetName "MyScaleSet"
$profile = New-AzAutoscaleProfile -Name "DefaultProfile" -ScaleCapacity "1" -MaximumCapacity "5" -MinimumCapacity "1" -DefaultCapacity "3"
Add-AzAutoscaleSetting -ResourceGroupName "MyResourceGroup" -TargetResourceId $scaleSet.Id -Profile $profile -Name "MyAutoscaleSetting"

# Backup a VM

$vault = Get-AzRecoveryServicesVault -ResourceGroupName "MyResourceGroup" -Name "MyRecoveryServicesVault"
$vm = Get-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"
Enable-AzRecoveryServicesBackupProtection -VaultId $vault.ID -ResourceId $vm.ID -PolicyName "DefaultPolicy"

# Restore a VM from a backup

$vault = Get-AzRecoveryServicesVault -ResourceGroupName "MyResourceGroup" -Name "MyRecoveryServicesVault"
$container = Get-AzRecoveryServicesBackupContainer -VaultId $vault.ID -ContainerType "AzureVM" -FriendlyName "MyContainer"
$item = Get-AzRecoveryServicesBackupItem -Container $container -WorkloadType "AzureVM" -Name "MyVM"
Restore-AzRecoveryServicesBackupItem -VaultId $vault.ID -Item $item -StorageAccountId (Get-AzStorageAccount -ResourceGroupName "MyResourceGroup" -Name "MyStorageAccount").Id

# Create a virtual network peering between two VNets

$vnet1 = Get-AzVirtualNetwork -ResourceGroupName "MyResourceGroup" -Name "MyVnet1"
$vnet2 = Get-AzVirtualNetwork -ResourceGroupName "MyResourceGroup" -Name "MyVnet2"
Add-AzVirtualNetworkPeering -Name "MyVnetPeering" -VirtualNetwork $vnet1 -RemoteVirtualNetworkId $vnet2.Id -AllowVirtualNetworkAccess

# Deploy a resource template

New-AzResourceGroupDeployment -ResourceGroupName "MyResourceGroup" -TemplateFile "azuredeploy.json" -TemplateParameterFile "azuredeploy.parameters.json"

# Configure a network security group to allow traffic from a specific IP

$rule = New-AzNetworkSecurityRuleConfig -Name "AllowSpecificIP" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "203.0.113.0/24" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80 -Access "Allow"
$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName "MyResourceGroup" -Name "MyNSG"
$nsg.SecurityRules.Add($rule)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
