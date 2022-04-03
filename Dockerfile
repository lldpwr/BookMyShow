FROM mcr.microsoft.com/powershell:7.0.3-debian-10
RUN pwsh -c 'Install-Module -Name Pode -Confirm:$false -Force -Scope AllUsers'
RUN pwsh -c 'Install-Module -Name Pode.Kestrel -Confirm:$false -Force -Scope AllUsers'
WORKDIR /usr/src/app/
COPY . .
EXPOSE 8086
CMD ["pwsh", "./startserver.ps1"]
