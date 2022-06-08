# Dieses Skript setzt den Swyx-Benutzer Status wenn der im HO ist
# Stannek GmbH v.1.01 - 13.01.2022 - E.Sauerbier

# Parameter
$SwyxServer = 'swyxsrv'
$SwyxUser = 'SwyxUserName'
$HOStatusText = 'HomeOffice'
$OfficeStatusText = '..'
$HOIndicator = '192.168.178.41'

# Verbindung mit der Swyx-Server herstellen
Connect-IpPbx $SwyxServer

# Prüft ob Client im HomeOffice ist und setzt den entsprechenden Status am Swyx-Server 
if (Test-Connection $HOIndicator -quiet) {
Set-IpPbxUserFreeStatusText -Name $SwyxUser -Text $HOStatusText
}
else
{
Set-IpPbxUserFreeStatusText -Name $SwyxUser -Text $OfficeStatusText
}

# Verbindung zum Swyx-Server trennen
Disconnect-IpPbx