# Dieses Skript aktiviert SNMP f�r die MIB-Abfrage via SNMP z.B. f�r PRTG
# Stannek GmbH v.1.01 - 13.01.2022 - E.Sauerbier

# Diese Skript muss als Administrator ausgef�hrt werden, ansonsten wird es nicht gestartet
#Requires -RunAsAdministrator

# ben�tigte WindowsFeature installieren
Add-WindowsFeature SNMP-Service, SNMP-WMI-Provider, RSAT-SNMP 

# Registry-Parameter f�r SNMP einstellen
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\parameters' -PropertyType "DWord" -Name "EnableAuthenticationTraps" -Value 0 -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\parameters\ValidCommunities' -PropertyType "DWord" -Name "public" -Value 8 -Force
Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\parameters\PermittedManagers'-Name "1" -Force