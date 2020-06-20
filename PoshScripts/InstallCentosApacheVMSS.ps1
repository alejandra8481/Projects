#Create custom script extension definition
$customConfig = @{
  "fileUris" = (,"https://apeausdevopssta01.blob.core.windows.net/vmsscustomscript/InstallApacheDefault.sh?st=2018-06-21T13%3A33%3A00Z&se=2019-06-23T13%3A33%3A00Z&sp=r&sv=2017-04-17&sr=b&sig=aaWy5XB3pIQTI0MMw6OahCaq1p%2B3uEc0BAjez4s%2BmBg%3D");
  "commandToExecute" = "./InstallApacheDefault.sh"
}

#Apply the custom script extension definition
# Get information about the scale set
$vmss = Get-AzureRmVmss `
          -ResourceGroupName "vmss-rg02" `
          -VMScaleSetName "mycentosvmss"

# Add the Custom Script Extension to install NGINX and configure basic website
$vmss = Add-AzureRmVmssExtension `
  -VirtualMachineScaleSet $vmss `
  -Name "customScriptautomateapache_v1" `
  -Publisher "Microsoft.Azure.Extensions" `
  -Type "CustomScript" `
  -TypeHandlerVersion 2.0 `
  -Setting $customConfig

# Update the scale set and apply the Custom Script Extension to the VM instances
Update-AzureRmVmss `
  -ResourceGroupName "vmss-rg02" `
  -Name "mycentosvmss" `
  -VirtualMachineScaleSet $vmss