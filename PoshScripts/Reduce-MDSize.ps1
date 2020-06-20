# This creates an empty 32GB disk against an existing VM in an existing Resource Group
$VMName = "vm-resize-disk"
$RGName = "rg-resize-disk"
$DiskSizeGB = 32
 
write-output "Getting StorageAccount for $VMName"
$URI = ((Get-AzureRmVM -ResourceGroupName $RGName -Name $VMName | select StorageProfile -ExpandProperty StorageProfile).OSDisk.Vhd).uri
$StoreStr = ([System.Uri]$URI).Host.Split(".")[0]
write-output "Storage account is: $StoreStr"
 
$ContainerStr = ([System.Uri]$URI).Segments[1].Trim("/")
write-output "Storage account OSDisk container is $ContainerStr"
 
$Store = Get-AzureRmStorageAccount -Name $StoreStr -ResourceGroupName $RGName
$StoreKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGName -Name $Store.StorageAccountName)[0].Value
$StoreContext = New-AzureStorageContext -StorageAccountName $Store.StorageAccountName -StorageAccountKey $StoreKey
 
$Contain = Get-AzureStorageContainer -Name $ContainerStr -Context $StoreContext
 
$VM = Get-AzureRMVM -Name $VMName -ResourceGroup $RGName
 
Write-Output "Adding empty $($DiskSizeGB)GiB disk to VM $VMName..."
Add-AzureRmVMDataDisk -VM $VM -Name "$($VMName)-empty" -VhdUri "$($Store.PrimaryEndpoints.Blob)$($Contain.Name)/$($VMName)-empty.vhd" -DiskSizeInGB $DiskSizeGB -Lun 0 -CreateOption Empty -Caching None
Update-AzureRmVM -ResourceGroupName $RGName -VM $VM
 
Write-Host "Removing empty disk from VM $VMName..."
Remove-AzureRmVMDataDisk -VM $VM -DataDiskNames "$($VMName)-empty"
Update-AzureRmVM -ResourceGroupName $RGName -VM $VM

# Change the -osdisk VHD file to new size (32GB)
# Note: make sure you have shrunk the disk from Windows to 32GB or below  first
$VMName = "vm-resize-disk"
$RGName = "rg-resize-disk"
$StorageAccountName = "sa-resize-disk"
$ContainerName = "vhds"
 
write-output "Using StorageAccount $StorageAccountName"
write-output "Using Container $ContainerName"
 
write-output "Getting storage account $StorageAccountName into variable"
$Store = Get-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $RGName
write-output "Getting storage keys for $StorageAccountName"
$StoreKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGName -Name $Store.StorageAccountName)[0].Value
write-output "Creating storage account context"
$StoreContext = New-AzureStorageContext -StorageAccountName $Store.StorageAccountName -StorageAccountKey $StoreKey
 
$Contain = Get-AzureStorageContainer -Name $ContainerName -Context $StoreContext
 
write-output "Getting properties of OSDisk"
$OSDiskVHD = ($VMName.ToLower())+"-osdisk.vhd"
$osDisk = Get-AzureStorageBlob -Context $StoreContext -Container $contain.Name -Blob $OSDiskVHD
 
write-output "Getting properties of the empty disk"
$emptyDisk = Get-AzureStorageBlob -Context $StoreContext -Container $contain.Name -Blob "$($VMName)-empty.vhd"
 
$footer = New-Object -TypeName byte[] -ArgumentList 512
write-output "Get footer of empty disk"
$downloaded = $emptyDisk.ICloudBlob.DownloadRangeToByteArray($footer, 0, $emptyDisk.Length - 512, 512)
$osDisk.ICloudBlob.Resize($emptyDisk.Length)
$footerStream = New-Object -TypeName System.IO.MemoryStream -ArgumentList (,$footer)
write-output "Write footer of empty disk to OSDisk"
$osDisk.ICloudBlob.WritePages($footerStream, $emptyDisk.Length - 512)
 
#write-output "Deleting empty disk VHD"
#Remove-AzureStorageBlob -Context $StoreContext -Container $contain.Name -Blob "$($VMName)-empty.vhd"
