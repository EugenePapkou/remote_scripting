# reboot the machines 192.0.0.8 and 192.0.0.5 remotely
Invoke-command -ScriptBlock {Get-WmiObject Win32_operatingSystem | 
Invoke-WmiMethod -name reboot} -computername 192.0.0.8, 192.0.0.5 -Credential $cred



# Get the list of running services on remote computers
$cred = Get-Credential
Invoke-command -ScriptBlock {Get-WmiObject win32_service | where {$_.state -eq "Running"}
    } -computername 192.0.0.5, 192.0.0.8 -Credential $cred



# Get the list of mac-addresses of all devices on a remote computer
$cred = Get-Credential
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName '192.0.0.8' -Credential $cred |
 Select-Object -Property MACAddress 



# Enable getting ip-addresses from DHCP on remote computers
$cred = Get-Credential 
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName '192.0.0.10', 
    '192.0.0.11' -Credential $cred | ForEach-Object -Process {$_.InvokeMethod("EnableDHCP", $null)} 

