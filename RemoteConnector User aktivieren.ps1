# Dieses Skript erstellt für User einer Gruppe das RC-Zertifikat und setzt ein Swyx-Passwort
# Stannek GmbH v.1.0 - 12.01.2021 - E.Sauerbier

# Verbindung mit dem Swyx-Server herstellen 
Import-Module IpPbx
Connect-IpPbx

# Hier das Passwort für das Stammzertifikat eingeben
$securestring = ConvertTo-SecureString -AsPlainText "XXXHierDasPasswortEintragenXXX" -Force

# Hier den Gruppennamen der RemoteConnector Gruppe angeben
$GroupName = "RemoteConnectorUser"

# User aus der Gruppe auslesen
$user = Get-IpPbxGroupMember -GroupName $GroupName


foreach ($u in $user)
{
if ($u.CertificateThumbprint.length -lt 3 ) {
Write-Host $u.name "bekommt ein neues Zertifikat:"
# RemoteConnector-Zertifikat erstellen
$cert = New-IpPbxClientCertificate -UserEntry $u -RootPassword $securestring -Confirm:$false
echo $cert.Thumbprint

# Erstellung des Swyx-User Logins
# Interne Nummer auslesen
$InternalNumber = Get-IpPbxInternalNumber -UserName $u.name | Where IsFaxNumber -ne True
# Passwort-Generierung nach dem Schema Swyx+Durchwahl (z.B. Swyx#12)
$Password = "Swyx#" + $InternalNumber.Number
# Swyx-Login aktivieren und Passwort setzen
Set-IpPbxUserLogin -EnableLogin -UserName $u.name -Password $password
} 
else {
Write-Host $u.name "RemoteConnector ist bereits für den User eingerichtet"
}
}
Disconnect-IpPbx