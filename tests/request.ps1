Start-Job { ./startserver.ps1};
Wait-Event -SourceIdentifier "" -Timeout 25;
$ip = (hostname -I) -split " " |  Select-Object -First 1
Write-Host "Ip address $ip"
Get-Job | Receive-Job
$content = Invoke-WebRequest -Uri http://${ip}:8086/pay | Select-Object -ExpandProperty RawContent
$content -match "succeed"
$content = Invoke-WebRequest -Uri http://${ip}:8086/Selectitem -Method Post -Body "{ 'index': 12345 }"  -ContentType "application/json" | Select-Object -ExpandProperty RawContent
$content -match "12345"
$content = Invoke-WebRequest -Uri http://${ip}:8086/shutdown | Select-Object -ExpandProperty RawContent
$content -match "Thank you"
