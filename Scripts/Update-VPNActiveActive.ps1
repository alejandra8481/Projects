# Declare your variables
$GWName = "GW-hub"
$VNetName = "VNet-hub"
$RG = "FW-Hybrid-Test"
$GWIPName2 = "VNet-hub-GW-pip2"
$GWIPconf2 = "gw2ipconf2"

# Create the public IP address, then add the second gateway IP configuration
$vnet = Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RG
$subnet = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$gw = Get-AzVirtualNetworkGateway -Name $GWName -ResourceGroupName $RG
$location = $gw.Location

# Enable active-active mode and update the gateway
Set-AzVirtualNetworkGateway -VirtualNetworkGateway $gw -EnableActiveActiveFeature 
