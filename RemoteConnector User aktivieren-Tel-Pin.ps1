# Dieses Skript erstellt für User einer Gruppe das RC-Zertifikat und setzt ein Swyx-Passwort
# Stannek GmbH v.1.01 - 09.06.2022 - E.Sauerbier

# Verbindung mit dem Swyx-Server herstellen 
Import-Module IpPbx
Connect-IpPbx

# Hier das Passwort für das Stammzertifikat eingeben
$securestring = ConvertTo-SecureString -AsPlainText 'XXXHierDasPasswortEintragenXXX' -Force

# Hier den Gruppennamen der RemoteConnector Gruppe angeben
$GroupName = "RemoteConnector-User"

# User aus der Gruppe auslesen
$user = Get-IpPbxGroupMember -GroupName $GroupName

# Schleife um das Passwort und Zertifikat pro User zu generieren und zu setzen
foreach ($u in $user)
{
if ($u.CertificateThumbprint.length -lt 3 ) {
Write-Host $u.name "bekommt ein neues Zertifikat:"
# RemoteConnector-Zertifikat erstellen
$cert = New-IpPbxClientCertificate -UserEntry $u -RootPassword $securestring -Confirm:$false
echo $cert.Thumbprint

# Erstellung des Swyx-User Logins
# Interne Nummer auslesen
$TelPIN = Get-IpPbxUser -UserName $u.name | Select-Object -ExpandProperty LanPhonePin
# Passwort-Generierung nach dem Schema Swyx+Tel-PIN(z.B. Swyx#12)
$Password = "Swyx#" + $TelPIN

# Swyx-Login aktivieren und Passwort setzen
Set-IpPbxUserLogin -EnableLogin -UserName $u.name -Password $password
} 
else {
Write-Host $u.name "RemoteConnector ist bereits für den User eingerichtet"
}
}

# Verbindung zum Swyx-Server trennen
Disconnect-IpPbx