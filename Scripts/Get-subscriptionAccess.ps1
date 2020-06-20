# List all accounts that have Owner, Contributor, Reader Role
# to what scope
$subscriptionScope = "/subscriptions/9a5db7af-43bd-4143-81e3-0e57ae339b9f"
Get-AzureRmRoleAssignment -Scope $subscriptionScope
$subscriptionName = "Azure CXP FT Internal Subscription MAHERNAN"
$resourcegroups = Get-AzureRmResourceGroup
$resources = Get-AzureRmResource

#Subscription Access
$currentaccess = Get-AzureRmRoleAssignment -Scope /subscriptions/9a5db7af-43bd-4143-81e3-0e57ae339b9f
    if($currentaccess){ 
        "UPN: " + $Currentaccess.signinname
        "RBAC Role: " + $currentaccess.roledefinitionname
        "AAD Object Type: " + $currentaccess.objecttype
        ""
    }

# Resource Groups Current Access
foreach($resourcegroup in $resourcegroups){
    $currentaccess = Get-AzureRmRoleAssignment -ResourceGroupName $resourcegroup.resourcegroupname
    if($currentaccess){
        "UPN: " + $Currentaccess.signinname
        "RBAC Role: " + $currentaccess.roledefinitionname
        "AAD Object Type: " + $currentaccess.objecttype
        ""
    }
}

#Resource Access
# Resource Groups Current Access
foreach($resource in $resources){
    $currentaccess = Get-AzureRmRoleAssignment -ResourceName ($resource.name) -ResourceType ($resource.ResourceType) -ResourceGroupName ($resource.ResourceType) -scope $subscriptionScope
    if($currentaccess){
        "UPN: " + $Currentaccess.signinname
        "RBAC Role: " + $currentaccess.roledefinitionname
        "AAD Object Type: " + $currentaccess.objecttype
        ""
    }
}