
#Login to RDS 
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com"
Get-RdsTenant

Get-RdsAppGroup -TenantName "alejandrapalacioscloudwvdtenant" -HostPoolName "wvdv1hp01"