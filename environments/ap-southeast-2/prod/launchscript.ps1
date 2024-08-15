# This script automates the process of setting up an IIS server on a Windows EC2 instance, installing the .NET Core 8 Hosting Bundle, 
# and deploying a simple "Hello World" web application. When the EC2 instance starts, this script will run, 
# and your IIS server will be ready to host the application. Firewall rules are also applied accordingly.



# Install IIS (Internet Information Services)
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Download the .NET Core Hosting Bundle
Invoke-WebRequest -Uri "https://dotnet.microsoft.com/download/dotnet-core/thank-you/runtime-8.0.0-windows-hosting-bundle-installer" -OutFile "dotnet-hosting.exe"

# Install the .NET Core Hosting Bundle
Start-Process -FilePath "dotnet-hosting.exe" -ArgumentList "/quiet" -NoNewWindow -Wait

# Create a directory for the application
New-Item -Path "C:\\inetpub\\wwwroot\\helloworld" -ItemType Directory

# Create a simple HTML file
Set-Content -Path "C:\\inetpub\\wwwroot\\helloworld\\index.html" -Value "<h1>Hello World from .NET Core 8!</h1>"

# Remove default IIS start page files
Remove-Item -Path "C:\\inetpub\\wwwroot\\iisstart.*" -Force

# Point IIS to the new application directory
Set-ItemProperty -Path "IIS:\\Sites\\Default Web Site" -Name "PhysicalPath" -Value "C:\\inetpub\\wwwroot\\helloworld"

# Configure Windows Firewall to allow inbound traffic on port 80 (HTTP)
New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow