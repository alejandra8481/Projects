
# Show the IPsec/IKE policy of a connection
$RG1          = "FW-Hybrid-Test"
$Connection16 = "Onprem-to-hub"
$connection6  = Get-AzVirtualNetworkGatewayConnection -Name $Connection16 -ResourceGroupName $RG1
$connection6.IpsecPolicies

#Add or update an IPsec/IKE policy for a connection
$connection6  = Get-AzVirtualNetworkGatewayConnection -Name $Connection16 -ResourceGroupName $RG1

$newpolicy6   = New-AzIpsecPolicy -IkeEncryption AES256 -IkeIntegrity SHA256 -DhGroup DHGroup14 -IpsecEncryption GCMAES256 -IpsecIntegrity GCMAES256 -PfsGroup None #-SALifeTimeSeconds 14400 -SADataSizeKilobytes 102400000

Set-AzVirtualNetworkGatewayConnection -VirtualNetworkGatewayConnection $connection6 -IpsecPolicies $newpolicy6

#You can get the connection again to check if the policy is updated
$connection6  = Get-AzVirtualNetworkGatewayConnection -Name $Connection16 -ResourceGroupName $RG1
$connection6.IpsecPolicies