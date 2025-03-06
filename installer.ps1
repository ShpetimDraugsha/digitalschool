# Check for admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script requires administrative privileges. Please run PowerShell as Administrator and try again."
    exit 1
}

# Install Chocolatey if not present
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    if ($?) { Write-Host "Chocolatey installed successfully!" -ForegroundColor Green }
    else { Write-Error "Failed to install Chocolatey."; exit 1 }
}

# List of apps to install
$apps = @(
    "xampp"
    "dbeaver"
    "git"
    "github-desktop"
    "vscode"
    "eclipse"
    "pycharm"
    "sublimetext3"
    "octoparse"
    "python --version=3.12.6"
    "screenbuilder"  # Verify availability in Chocolatey
    "scratch"
    "veyon"
)

# Install apps with progress
$total = $apps.Count
$count = 0
foreach ($app in $apps) {
    $count++
    Write-Progress -Activity "Installing Applications" -Status "$count of $total" -PercentComplete (($count / $total) * 100)
    Write-Host "Installing $app..." -ForegroundColor Cyan
    try {
        choco install $app -y --ignore-checksums --no-progress
        Write-Host "$app installed successfully" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to install $app : $_"
    }
}

Write-Host "Installation complete! Enjoy your new tools." -ForegroundColor Green
