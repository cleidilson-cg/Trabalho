FROM microsoft/iis:10.0.14393.206
MAINTAINER yros.aguiar@pixeon.cloud

ARG APP_NAME=app

SHELL ["powershell"]

RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45
RUN mkdir c:\${APP_NAME} 
COPY  . c:\${APP_NAME}
RUN Remove-WebSite -Name 'Default Web Site'
RUN New-Website -Name '${APP_NAME}' -Port 80 \
    -PhysicalPath '${APP_NAME}' -ApplicationPool '.NET v4.5'
EXPOSE 80

CMD Write-Host IIS Started... ; \
    while ($true) { Start-Sleep -Seconds 3600 }