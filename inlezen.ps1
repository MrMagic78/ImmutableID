####### Script om IMID.CSV (welke uit uitlezen.ps1 is gekomen) in te lezen in AzureAD.
####### https://www.microsoft.com/en-us/download/details.aspx?id=54616 = Windows Management Framework 5.1 deze is nodig voor Windows 7, Windows 8.1, Server 2008 R2/2012/2012R2.
####### Reboot
####### Install-Module MSOnline
####### Indien foutmeldingen dan [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

connect-msolservice
$users = import-csv “c:\temp\IMID.csv”
ForEach ($item in $users)

{
$UPN = $item.(“UserPrincipalName”)

$IMID = $item.(“ImmutableID”)

Set-MsolUser -UserPrincipalName $UPN -ImmutableId $IMID
}