#Connect-AzAccount

#Install the PowerShell module for "active" user
Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force

#Verify installation by printing the Az module version
Get-InstalledModule -Name Az -AllVersions | Select-Object Name,Version