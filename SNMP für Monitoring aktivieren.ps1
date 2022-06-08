# Dieses Skript aktiviert SNMP für die MIB-Abfrage via SNMP z.B. für PRTG
# Stannek GmbH v.1.01 - 13.01.2022 - E.Sauerbier

# Diese Skript muss als Administrator ausgeführt werden, ansonsten wird es nicht gestartet
#Requires -RunAsAdministrator

# benötigte WindowsFeature installieren
Add-WindowsFeature SNMP-Service, SNMP-WMI-Provider, RSAT-SNMP 

# Registry-Parameter für SNMP einstellen
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\parameters' -PropertyType "DWord" -Name "EnableAuthenticationTraps" -Value 0 -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\parameters\ValidCommunities' -PropertyType "DWord" -Name "public" -Value 8 -Force
Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\parameters\PermittedManagers'-Name "1" -Force