az vmss update --name "mycentosvmss" --resource-group "vmss-rg02"

az vmss extension delete --name "LinuxDiagnostic" --resource-group "vmss-rg02" --vmss-name "mycentosvmss"

az vmss extension set --name "LinuxDiagnostic" --vmss-name "mycentosvmss" --resource-group "vmss-rg02" --publisher "Microsoft.Azure.Diagnostics" --version 3.0 --protected-settings "C:\Users\mahernan\OneDrive - Microsoft\Documents\VSTSRepo\CodeBase\ConfigurationFiles\LinuxPrivateConfig.json" --settings "C:\Users\mahernan\OneDrive - Microsoft\Documents\VSTSRepo\CodeBase\ConfigurationFiles\LinuxPublicConfig.json"