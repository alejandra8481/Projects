Stop-AzVM -ResourceGroupName "PAN-RG" -Name "PAN-FW-1"
Stop-AzVM -ResourceGroupName "PAN-RG" -Name "PAN-FW-2"

$nic = Get-AzNetworkInterface -Name "pan-fw-1644" -ResourceGroupName "PAN-RG"
$nic.EnableAcceleratedNetworking = $True
$nic | Set-AzNetworkInterface

$nic = Get-AzNetworkInterface -Name "PAN-FW-1-Trust-NIC" -ResourceGroupName "PAN-RG"
$nic.EnableAcceleratedNetworking = $True
$nic | Set-AzNetworkInterface

$nic = Get-AzNetworkInterface -Name "PAN-FW-1-Untrust-NIC" -ResourceGroupName "PAN-RG"
$nic.EnableAcceleratedNetworking = $True
$nic | Set-AzNetworkInterface

$nic = Get-AzNetworkInterface -Name "pan-fw-2921" -ResourceGroupName "PAN-RG"
$nic.EnableAcceleratedNetworking = $True
$nic | Set-AzNetworkInterface

$nic = Get-AzNetworkInterface -Name "PAN-FW-2-Trust-NIC" -ResourceGroupName "PAN-RG"
$nic.EnableAcceleratedNetworking = $True
$nic | Set-AzNetworkInterface

$nic = Get-AzNetworkInterface -Name "PAN-FW-2-Untrust-NIC" -ResourceGroupName "PAN-RG"
$nic.EnableAcceleratedNetworking = $True
$nic | Set-AzNetworkInterface

Start-AzVM -ResourceGroupName "PAN-RG" -Name "PAN-FW-1"
Start-AzVM -ResourceGroupName "PAN-RG" -Name "PAN-FW-2"