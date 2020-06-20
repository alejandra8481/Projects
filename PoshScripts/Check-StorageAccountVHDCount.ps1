<#
.NOTES
 	==================================================================================================================================================================
	File:		Check-StorageAccountVHDCount.ps1	
	Purpose:	Audits the amount of VM locked VHDs per storage account 
	Version: 	1.0.0.1 - May 2017 - Alejandra Hernandez and Javier Cevallos (MCS)   
 	==================================================================================================================================================================
 .SYNOPSIS
	Audits the amount of VM locked VHDs per storage account 
 .DESCRIPTION
	Audits all storage accounts within a subscription and checks for .VHD files which are currently locked and being used by a VM. 
	This Runbook script provides insights on whether we are hitting the throttling limit for Premium (max 80K IOPS) and Standard (max 20k IOPS) storage accounts. 
 .EXAMPLE
	Default: 
		Check-StorageAccountVHDCount `
		 -SubscriptionName = "S2M_WS3_ARM" 
   =================================================================================================================================================================
#>

param(

	[Parameter(Mandatory=$false)][string] $SubscriptionName = "S2M_WS3_ARM"

)


try{
    #Define the credential asset used by runbook will use to authenticate to Azure.
    $CredentialAssetName = 'xaAzureAutomation01'
    $Cred = Get-AutomationPSCredential -Name $CredentialAssetName
        if(!$Cred) {
            Throw "Could not find an Automation Credential Asset named '${CredentialAssetName}'. Verify the account referenced exists in this Automation Account."
        }
   
    #Login to Azure
    $Account = Login-AzureRmAccount -Credential $Cred
        if(!$Account) {
            Throw "Could not login to Azure using the credential asset '${CredentialAssetName}'. Make sure the referenced credential asset is correct."
        }
    Write-Output "Successfully logged into Azure using $CredentialAssetName"
     
    #Login to Subscription.
    Select-AzureRMSubscription -SubscriptionName $SubscriptionName
    Write-Output "The subscription context is set to $SubscriptionName"
}
catch{
    Write-Error "Error logging in subscription $SubscriptionName"
}

#Default Values for Variables
$AzStorAccName = Get-AzureRmStorageAccount #Storage account name
#$AzStorAccName = 'savtechsalrsscus' #Storage account name
#$AzResGroup = 'rg-scusa' #resource group name

foreach($sta in $AzStorAccName){
    $VHDsinAct = 0
    $Containers = $null
    $AllBlobs = $null
    
    $Containers = Get-AzureRMStorageAccount -Name $sta.storageaccountname -ResourceGroupName $sta.resourcegroupname | Get-AzureStorageContainer
    foreach($container in $containers){
        $AllBlobs = Get-AzureRMStorageAccount -Name $sta.storageaccountname -ResourceGroupName $sta.resourcegroupname | 
        Get-AzureStorageContainer | where {$_.Name -eq $container.name} | Get-AzureStorageBlob | where {$_.Name.EndsWith('.vhd')}

        foreach ($Blob in $AllBlobs){
            if($Blob.ICloudBlob.Properties.LeaseStatus -eq 'Locked'){
                #Assume its used by a VM
                $VHDsinAct++
            }
        } 
    }
    

    if($VHDsinAct -le 40){
        $staName = $sta.storageaccountname
        Write-Output "Total of $VHDsinAct leased VHDs in storage account $staName"
    }
    else{ #more than 40
        $staName = $sta.storageaccountname
        Write-Output "*** More than 40 Leased VHDs ($VHDsinAct) in storage account $staName ***"
    }
}
