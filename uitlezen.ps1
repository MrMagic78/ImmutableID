####### Script om alle of 1 gebruiker te exporteren naar CSV met ImmutableID. Deze kan daarna worden ingelezen in de AzureAD.
####### Dit script moet je draaien op een OnPremise DC.

[System.Console]::ForegroundColor = [System.ConsoleColor]::White
clear-host
Import-module activedirectory

write-host Kies 1 van de volgende opties:
write-host
write-host ‘1) Vraag het ImmutableID op voor 1 gebruiker. Naam die je in moet vullen is sAMAccountName dus zonder @.’
write-host ‘2) Vraag het ImmutabaleID op voor alle gebruikers.’
write-host ‘3) Stop’ -ForegroundColor Red
write-host
$option = Read-Host “Maak een keuze [1-3]”

switch ($option)
{
‘1’{
write-verbose “Optie 1 geselecteerd.”
$GetUser = Read-Host -Prompt ‘Vul de gebruikersnaam in:’
$Users = get-aduser $GetUser | select UserPrincipalName,@{label=”ImmutableID”;expression={[System.Convert]::ToBase64String($_.objectguid.ToByteArray())}}
$Users
}

‘2’{
Write-Verbose "Optie 2 geselecteerd."
Write-host
Write-host 'Vul het pad in waar de export moet komen te staan. Bijv. c:\temp\IMID.csv'

$Path = Read-Host -Prompt ‘Pad’

$Users = get-aduser -filter * | select UserPrincipalName,@{label=”ImmutableID”;expression={[System.Convert]::ToBase64String($_.objectguid.ToByteArray())}}
$users
$users | export-csv $Path

}
‘3’{
write-verbose “Optie 3 geselecteerd.”
break
}
}
