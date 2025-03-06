# List of applications to install
$apps = @(
    "xampp",
    "dbeaver",
    "git",
    "github-desktop",
    "vscode",
    "eclipse",
    "pycharm",
    "sublimetext4",
    "octoparse",
    "python",
    "screenbuilder",
    "scratch",
    "veyon"
)

# Function to install Chocolatey if not already installed
function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..." -ForegroundColor Yellow

        # Install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

        # Verify Chocolatey installation
        if (Get-Command choco -ErrorAction SilentlyContinue) {
            Write-Host "Chocolatey installed successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to install Chocolatey. Please install it manually." -ForegroundColor Red
            exit
        }
    } else {
        Write-Host "Chocolatey is already installed." -ForegroundColor Green
    }
}

# Function to install applications using Chocolatey
function Install-Apps {
    param (
        [string[]]$appList
    )

    foreach ($app in $appList) {
        Write-Host "Installing $app..." -ForegroundColor Cyan
        choco install $app -y
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$app installed successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to install $app." -ForegroundColor Red
        }
    }
}

# Main script execution
try {
    # Ensure Chocolatey is installed
    Install-Chocolatey

    # Install the applications
    Install-Apps -appList $apps
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
