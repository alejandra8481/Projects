New-SelfSignedCertificate -Subject lookupwebapp01.alejandrapalacios.cloud -DnsName lookupwebapp01.alejandrapalacios.cloud -CertStoreLocation Cert:\LocalMachine\My -NotAfter (Get-Date).AddYears(1)
Get-ChildItem -Path cert:\LocalMachine\My

$cert = (Get-ChildItem -Path cert:\LocalMachine\My\00998832788EA1B7100BC0B301E90F4895934207)
$password = ConvertTo-SecureString -String "1234" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -Password $password -FilePath c:\sslookupwebapp01.alejandrapalacios.cloud_private.pfx
#Export-Certificate -Cert $cert -FilePath c:\sslookupwebapp01.alejandrapalacios.cloud_public.cer