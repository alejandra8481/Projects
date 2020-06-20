<#
 Get Image Details Sample
#>

$location = "eastus2"
$publisherName = "MicrosoftSQLServer"
$Offer = "SQL2008R2SP3-WS2008R2SP1" 
$Sku = "Enterprise"
$version = "latest"

Get-AzVMImagePublisher -Location $location
Get-AzVMImageOffer -Location $location -PublisherName $publisherName
Get-AzVMImageSku -location $location -PublisherName $publisherName -Offer $Offer
Get-AzVMImage -Location $location -PublisherName $publisherName -Offer $Offer -Skus $Sku
Get-AzVMImage -Location $location -PublisherName $publisherName -Offer $Offer -Skus $Sku -Version $version
