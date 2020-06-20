# Sign in to Windows Virtual Desktop by using the TenantCreator user account with this cmdlet:
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com"

# Create a new Windows Virtual Desktop tenant associated with the Azure Active Directory tenant:
New-RdsTenant -Name "alejandrapalacioscloudwvdtenant" -AadTenantId "65138c5c-e304-4903-a188-a7878f494809" -AzureSubscriptionId "8a7f61b3-51ce-4967-94db-bf03156455d7"

#Assign access to another admin user
New-RdsRoleAssignment -TenantName "alejandrapalacioscloudwvdtenant" -SignInName "alejandrapalacios@alejandrapalacios.cloud" -RoleDefinitionName "RDS Owner"
