$appgw = Get-AzApplicationGateway -ResourceGroupName "webappvnetintegrated-rg" -Name "mywebappgwv1"

$appgw = Add-AzApplicationGatewayAuthenticationCertificate -ApplicationGateway $appgw -Name "lookupwebapp01_alejandrapalacios_cloud_geotrust" -CertificateFile "C:\Users\mahernan\OneDrive - Microsoft\Documents\AppGwaySSCerts\digicert\lookupwebapp01_alejandrapalacios_cloud_geotrust.cer"
$password = ConvertTo-SecureString "2232802a" -AsPlainText -Force
$AppGW = Add-AzApplicationGatewaySslCertificate -ApplicationGateway $AppGW -Name "lookupwebapp01_alejandrapalacios_cloud" -CertificateFile "C:\Users\mahernan\OneDrive - Microsoft\Documents\AppGwaySSCerts\digicert\lookupwebapp01_alejandrapalacios_cloud.pfx" -Password $password

#$appgw = Remove-AzApplicationGatewayTrustedRootCertificate -Name "ssalejandrapalacios.cloud_docsexportsteps_public" -ApplicationGateway $appgw
#$appgw = Remove-AzApplicationGatewaySslCertificate -Name "sslookupwebapp01.alejandrapalacios.cloud_docsexportsteps_public" -ApplicationGateway $appgw
#$appgw = Add-AzApplicationGatewayTrustedRootCertificate -ApplicationGateway $appgw -Name "ssalejandrapalacios.cloud_public" -CertificateFile "c:\ssalejandrapalacios.cloud_public.cer"

#$appgw = Set-AzApplicationGatewayRootCertificate -ApplicationGateway $appgw -Name "ssalejandrapalacios.cloud_public" -CertificateFile "c:\ssalejandrapalacios.cloud_docsexportsteps_public.cer"

$appgw = Set-AzApplicationGateway -ApplicationGateway $appgw

$appgw.AuthenticationCertificates
$appgw.SslCertificates
$appgw.TrustedRootCertificates


