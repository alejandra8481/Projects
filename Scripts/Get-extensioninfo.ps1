Get-AzureRmVmImagePublisher -Location "eastus" | `
Get-AzureRmVMExtensionImageType | `
Get-AzureRmVMExtensionImage | Select Type, Version

Get-AzureRmVmImagePublisher -Location "eastus" | `
Get-AzureRmVMExtensionImageType -PublisherName "Microsoft.EnterpriseCloud.Monitoring" | `
Get-AzureRmVMExtensionImage | Select Type, Version

az vmss extension set --name "OmsAgentForLinux" --publisher "Microsoft.EnterpriseCloud.Monitoring" --resource-group "vmss-rg02" --vmss-name "mycentosvmss" --settings "{'workspaceId':'fdb64732-82ec-4118-887b-32007ef9483f'}" --protected-settings "{'workspaceKey':'4lYinTKi9atufs8Qzc5f3Qakt2pdU9tAiuvrq9ZX0jBXkTw8MiWBFJYSoUbhJ3+FCSVIdsgLglA45H1Ql4Shqg=='}"