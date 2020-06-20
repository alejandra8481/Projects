<#
 Create VMs Azure Sample Script
#>

# Variables COMPLETE!
$rgName="ert-rg"
$location="eastus"
$cred = Get-Credential -Message 'Enter a username and password for the virtual machine.'
$vnetName = "net-eaus-vnet01"
$VnetRG = "networking-rg"
$subnetName = "frontend"
$Nic1 = 'ertvmNic1'
$Nic2 = 'ertvmNic2'
$Nic3 = 'ertvmNic3'
$AvailabilitySet = "ert-webas01"
$VM1 = "ertwebvm01"
$VM2 = "ertwebvm02"
$VM3 = "ertwebvm03"
$VMSize = "Standard_DS2"
$VMImagePublisher = "microsoftwindowsserver" #"center-for-internet-security-inc"
$VMImageOffer = "WindowsServer" #"cis-centos-7-v2-1-1-l1"
$VMImageSku = "2016-Datacenter-smalldisk" #"cis-centos7-l1"
$VMImageversion =  "2016.127.20180315" #"1.0.0"
$OsDiskName1 = "ertwebvm01osdisk"
$OSDiskSize = 30
$OSDiskType = "StandardLRS"

#Get Subnet ID
$vnetID = (Get-AzureRmResource -ResourceName $vnetName -ResourceGroupName $VnetRG).resourceID
$SubnetID = $vnetID +"/subnets/" + $subnetName

# Create three virtual network cards and associate with public IP address and NSG.
$nicVM1 = New-AzureRmNetworkInterface -ResourceGroupName $rgName -Location $location `
  -Name $Nic1 -SubnetId $subnetid

$nicVM2 = New-AzureRmNetworkInterface -ResourceGroupName $rgName -Location $location `
  -Name $Nic2 -SubnetId $subnetid

$nicVM3 = New-AzureRmNetworkInterface -ResourceGroupName $rgName -Location $location `
  -Name $Nic3 -SubnetId $subnetid

# Create an availability set.
$as = New-AzureRmAvailabilitySet -ResourceGroupName $rgName -Location $location `
  -Name $AvailabilitySet -Sku Aligned -PlatformFaultDomainCount 3 -PlatformUpdateDomainCount 5
#$as = Get-AzureRmAvailabilitySet -ResourceGroupName $rgName -Name $AvailabilitySet

# Create three virtual machines.

# ############## VM1 ###############

# Create a virtual machine configuration
$vmConfig = New-AzureRmVMConfig -VMName $VM1 -VMSize $VMSize -AvailabilitySetId $as.Id | `
  Set-AzureRmVMOperatingSystem -Windows -ComputerName $VM1 -Credential $cred | `
  Set-AzureRmVMSourceImage -PublisherName $VMImagePublisher -Offer $VMImageOffer `
  -Skus $VMImageSku -Version latest | Add-AzureRmVMNetworkInterface -Id $nicVM1.Id | `
  Set-AzureRmVMOSDisk -Name $OSDiskName1 -DiskSizeInGB $OSDiskSize -CreateOption FromImage

# Create a virtual machine
$vm1 = New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vmConfig -licensetype "Windows_Server"

# ############## VM2 ###############

# Create a virtual machine configuration
# Create a virtual machine configuration
$vmConfig = New-AzureRmVMConfig -VMName $VM2 -VMSize $VMSize -AvailabilitySetId $as.Id | `
  Set-AzureRmVMOperatingSystem -Windows -ComputerName $VM2 -Credential $cred | `
  Set-AzureRmVMSourceImage -PublisherName $VMImagePublisher -Offer $VMImageOffer `
  -Skus $VMImageSku -Version latest | Add-AzureRmVMNetworkInterface -Id $nicVM2.Id | `
  Set-AzureRmVMOSDisk -Name $OSDiskName2 -DiskSizeInGB $OSDiskSize -CreateOption FromImage

# Create a virtual machine
$vm2 = New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vmConfig -licensetype "Windows_Server"

# ############## VM3 ###############

# Create a virtual machine configuration
# Create a virtual machine configuration
$vmConfig = New-AzureRmVMConfig -VMName $VM3 -VMSize $VMSize -AvailabilitySetId $as.Id | `
  Set-AzureRmVMOperatingSystem -Windows -ComputerName $VM3 -Credential $cred | `
  Set-AzureRmVMSourceImage -PublisherName $VMImagePublisher -Offer $VMImageOffer `
  -Skus $VMImageSku -Version latest | Add-AzureRmVMNetworkInterface -Id $nicVM3.Id | `
  Set-AzureRmVMOSDisk -Name $OSDiskName3 -DiskSizeInGB $OSDiskSize -CreateOption FromImage

# Create a virtual machine
$vm3 = New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vmConfig -licensetype "Windows_Server"
