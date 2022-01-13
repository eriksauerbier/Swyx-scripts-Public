# Dieses Skript stellt die Statussignalisierung von UDP auf TCP für alle Benutzer um
# Stannek GmbH v.1.01 - 13.01.2022 - E.Sauerbier

# Verbindung mit der Swyx-Server herstellen
Connect-IpPbx
# Änderung des Transport-Modus für alle Benutzer auf TCP
Get-IpPbxUser | Set-IpPbxUserProfileElement -KeyName "SIPTransportMode" -KeyValue "TCP"

# Verbindung zum Swyx-Server trennen
Disconnect-IpPbx