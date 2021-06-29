[CmdletBinding()]
param (
    $Port=8086
)

Import-Module Pode
Import-Module Pode.Kestrel
Start-PodeServer -ListenerType Kestrel {
    # Find computer ip
    $ip = (hostname -I) -split " " |  Select-Object -First 1

    #Attach port 8086 to the local machine address and use HTTP protocol
    Add-PodeEndpoint -Address $ip -Port $Port -Protocol HTTP

    # root
    Add-PodeRoute -Method Post -Path '/' -ScriptBlock {
        Move-PodeResponseUrl -Url '/html'
    }

    #Select item
    Add-PodeRoute -Method Get -Path '/Selectitem' -ScriptBlock {
        $item = $WebEvent.Data.item
        Write-PodeTextResponse -value '<html><body><h1>Book My Show</h1><p>You have selected {0} </p><a href="/pay">Pay</a><br><a href="/html">Main Page</a></body></html>' -ContentType "Text/html"
    }

    # pay 
    Add-PodeRoute -Method Post -Path '/pay' -ScriptBlock {
        Write-PodeTextResponse -value '<html><body><h1>Book My Show</h1><p>Payment succed</p><a href="/html">Main Page</a></body></html>' -ContentType "Text/html"
    }

    # shutdown
    Add-PodeRoute -Method Post -Path '/UpdateLabel' -ScriptBlock {
        Write-PodeTextResponse -value '<html><body><h1>Book My Show</h1><p>Thank you</p></body></html>' -ContentType "Text/html"
        Close-PodeServer
    }

    # html file
    Add-PodeStaticRoute -Path '/html' -Source './html' -Defaults @('index.html')
}
 