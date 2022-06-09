# Dieses Skript setzt für alle Benutzer innerhalb der definierten Gruppe das Passwort anhand der Telefon-PIN oder Durchwahl (entsprechend auskommentieren)
# Stannek GmbH v.1.1 - 09.06.2022 - E.Sauerbier

# Verbindung mit dem Swyx-Server herstellen 
Import-Module IpPbx
Connect-IpPbx

# Hier den Gruppennamen angeben
$GroupName = "RemoteConnector-User"

# User aus der Gruppe auslesen
$user = Get-IpPbxGroupMember -GroupName $GroupName

# Schleife um das Passwort pro User zu generieren und zu setzen
foreach ($u in $user)
{
# Telefon-PIN auslesen
$TelPIN = Get-IpPbxUser -UserName $u.name | Select-Object -ExpandProperty LanPhonePin
# Passwort-Generierung nach dem Schema Swyx+Tel-PIN (z.B. Swyx#12)
$Password = "Swyx#" + $TelPIN

# Interne Nummer auslesen
#$InternalNumber = Get-IpPbxInternalNumber -UserName $u.name | Select-Object Number
# Passwort-Generierung nach dem Schema Swyx+Durchwahl (z.B. Swyx#12)
#$Password = "Swyx#" + $InternalNumber[0].Number

# Swyx Passwort setzen
Set-IpPbxUserLogin -EnableLogin -UserName $u.name -Password $password

}

# Verbindung zum Swyx-Server trennen
Disconnect-IpPbx