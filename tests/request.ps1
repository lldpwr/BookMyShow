$ip = (hostname -I) -split " " |  Select-Object -First 1
Write-Host "Ip address $ip"
$content = Invoke-WebRequest -Uri http://${ip}:8086/pay | Select-Object -ExpandProperty RawContent
$content.ToString()
Invoke-WebRequest -Uri http://${ip}:8086/Selectitem -Method Post -Body "{ 'item': 12345 }"  -ContentType "application/json" | Select-Object -ExpandProperty RawContent
Invoke-WebRequest -Uri http://${ip}:8086/pay | Select-Object -ExpandProperty RawContent
Invoke-WebRequest -Uri http://${ip}:8086/shutdown | Select-Object -ExpandProperty RawContent