$ip = (hostname -I) -split " " |  Select-Object -First 1
Invoke-WebRequest -Uri http://${ip}:8086/html
Invoke-WebRequest -Uri http://${ip}:8086/Selectitem -Method Post -Body "{ 'item': 12345 }"  -ContentType "application/json"
Invoke-WebRequest -Uri http://${ip}:8086/pay
Invoke-WebRequest -Uri http://${ip}:8086/shutdown