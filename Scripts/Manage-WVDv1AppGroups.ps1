
#Login to RDS 
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com"
Get-RdsTenant

# create a new empty RemoteApp app group
New-RdsAppGroup "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group" -ResourceType "RemoteApp"

#To verify that the app group was created, you can run the following cmdlet to see a list of all app groups for the host pool.
Get-RdsAppGroup "alejandrapalacioscloudwvdtenant" "wvdv1hp01"

#Run the following cmdlet to get a list of Start menu apps on the host pool's virtual machine image. Write down the values for FilePath, IconPath, IconIndex, and other important information for the application that you want to publish.
Get-RdsStartMenuApp "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group"

#Run the following cmdlet to install the application based on AppAlias. AppAlias becomes visible when you run the output from step 3.
New-RdsRemoteApp "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group" -Name paint -AppAlias paint

#(Optional) Run the following cmdlet to publish a new RemoteApp program to the application group created in step 1.
New-RdsRemoteApp "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group" -Name wordpad -Filepath "C:\Program Files\Windows NT\Accessories\wordpad.exe" -IconPath "C:\Program Files\Windows NT\Accessories\wordpad.exe" -IconIndex 0

#To verify that the app was published, run the following cmdlet.
Get-RdsRemoteApp "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group"

#Run the following cmdlet to grant users access to the RemoteApp programs in the app group.
Get-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "Desktop Application Group"
Remove-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "Desktop Application Group" -UserPrincipalName rdsuser03@alejandrapalacios.cloud
Remove-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "Desktop Application Group" -UserPrincipalName rdsuser04@alejandrapalacios.cloud
Get-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "Desktop Application Group"

Get-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group"
Add-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group" -UserPrincipalName rdsuser03@alejandrapalacios.cloud
Add-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group" -UserPrincipalName rdsuser04@alejandrapalacios.cloud
Get-RdsAppGroupUser "alejandrapalacioscloudwvdtenant" "wvdv1hp01" "RemoteApp Application Group"