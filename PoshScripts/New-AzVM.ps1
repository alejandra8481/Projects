$VMLocalAdminUser = "labadmin"
$VMLocalAdminSecurePassword = ConvertTo-SecureString "P@ssw0rd!12345" -AsPlainText -Force
$LocationName = "eastus"
$ResourceGroupName = "ws2008-rg"
$ComputerName = "ws2008R2SP1"
$VMName = "ws2008R2SP1"
$VMSize = "Standard_B2ms"

$NetworkName = "Vnet-Onprem"
$NICName = "ws2008R2SP1-nic"
$SubnetName = "SN-Corp"
#$SubnetAddressPrefix = "10.0.0.0/24"
#$VnetAddressPrefix = "10.0.0.0/16"

#$SingleSubnet = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressPrefix
#$Vnet = New-AzVirtualNetwork -Name $NetworkName -ResourceGroupName $ResourceGroupName -Location $LocationName -AddressPrefix $VnetAddressPrefix -Subnet $SingleSubnet
New-AzResourceGroup -Name $ResourceGroupName -Location "eastus"
$vnet = Get-AzVirtualNetwork -Name $NetworkName -ResourceGroupName "FW-Hybrid-Test"
$NIC = New-AzNetworkInterface -Name $NICName -ResourceGroupName $ResourceGroupName -Location $LocationName -SubnetId $Vnet.Subnets[0].Id

$Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword);

$VirtualMachine = New-AzVMConfig -VMName $VMName -VMSize $VMSize
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $ComputerName -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2008-R2-SP1' -Version latest

New-AzVM -ResourceGroupName $ResourceGroupName -Location $LocationName -VM $VirtualMachine -Verbose