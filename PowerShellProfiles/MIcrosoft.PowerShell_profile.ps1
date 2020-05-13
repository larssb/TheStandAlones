# Generate a nice twisted BDD Ascii art block
# http://www.patorjk.com/software/taag was used to generate the ASCII art 
$AsciiArtBlock = @"
______                  _
| ___ \                | |
| |_/ / ___ _ __   __ _| |_ ___ ___  ___  _ __
| ___ \/ _ \ '_ \ / _` | __/ __/ __|/ _ \| '_ \
| |_/ /  __/ | | | (_| | |_\__ \__ \ (_) | | | |
______ \___|_| |_|\__, |\__|___/___/\___/|_| |_|
|  _  \    (_)     __/ |
| | | |_ __ ___   _____ _ __
| | | | '__| \ \ / / _ \ '_ \
| |/ /| |  | |\ V /  __/ | | |
______|_|  |_| \_/ \___|_| |_|                          _
|  _  \             | |                                | |
| | | |_____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_
| | | / _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
| |/ /  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_
|___/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
                            | |
                            |_|
"@
Write-Host $AsciiArtBlock -ForegroundColor Green

# Set default location to code location
Set-Location 'THE_PWD_LOCATION'

# Setup Posh-Git, for Git cli prompt integration
[String]$posh_git_module_name = "posh-git"
if (Get-Module -Name $posh_git_module_name -ListAvailable -ErrorAction SilentlyContinue)
{
    Import-Module -Name $posh_git_module_name -Force
} else
{
    Write-Output "The $posh_git_module_name module was not found. Install it: Install-Module -Name $posh_git_module_name -Scope CurrentUser -AllowPrerelease -Force"
}

# Customize the shell title bar
$host.ui.RawUI.WindowTitle = 'YOUR_PowerShell_Shell_Window_Text'

# For PowerShell to use the Proxy system settings. The bewlow is PS 6 core + compatible
# $true to the System.Net.WebProxy constructor is to indicate that the proxy should be bypassed for local addresses
[System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy('http://PROXY_IP:PROXY_PORT', $true)
[System.Net.Http.HttpClient]::DefaultProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
