[Reflection.Assembly]::LoadWithPartialName("System.Web")| out-null
$URI="myNamespace.servicebus.windows.net/myEventHub"
$Access_Policy_Name="RootManageSharedAccessKey"
$Access_Policy_Key="myPrimaryKey"
#Token expires now+300
$Expires=([DateTimeOffset]::Now.ToUnixTimeSeconds())+300
$SignatureString=[System.Web.HttpUtility]::UrlEncode($URI)+ "`n" + [string]$Expires
$HMAC = New-Object System.Security.Cryptography.HMACSHA256
$HMAC.key = [Text.Encoding]::ASCII.GetBytes($Access_Policy_Key)
$Signature = $HMAC.ComputeHash([Text.Encoding]::ASCII.GetBytes($SignatureString))
$Signature = [Convert]::ToBase64String($Signature)
$SASToken = "SharedAccessSignature sr=" + [System.Web.HttpUtility]::UrlEncode($URI) + "&sig=" + [System.Web.HttpUtility]::UrlEncode($Signature) + "&se=" + $Expires + "&skn=" + $Access_Policy_Name
$SASToken