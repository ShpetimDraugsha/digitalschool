# List of applications to install
$apps = @(
    "Xampp",
    "DBeaver",
    "Git",
    "GitHub Desktop",
    "Visual Studio Code",
    "Eclipse",
    "PyCharm",
    "Sublime Text",
    "Octoparse",
    "Python",
    "ScreenBuilder",
    "Scratch",
    "Veyon"
)

# Function to install winget if not already installed
function Install-Winget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "winget is not installed. Installing winget..." -ForegroundColor Yellow

        # Download the App Installer package from Microsoft Store
        $url = "https://aka.ms/getwinget"
        $installerPath = "$env:TEMP\winget-installer.msixbundle"

        Write-Host "Downloading winget installer..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $url -OutFile $installerPath

        # Install the App Installer package
        Write-Host "Installing winget..." -ForegroundColor Cyan
        Add-AppxPackage -Path $installerPath

        # Clean up the installer
        Remove-Item -Path $installerPath -Force

        # Verify winget installation
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Host "winget installed successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to install winget. Please install it manually." -ForegroundColor Red
            exit
        }
    } else {
        Write-Host "winget is already installed." -ForegroundColor Green
    }
}

# Function to install applications using winget
function Install-Apps {
    param (
        [string[]]$appList
    )

    foreach ($app in $appList) {
        Write-Host "Installing $app..." -ForegroundColor Cyan
        winget install --id $app -e --silent
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$app installed successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to install $app." -ForegroundColor Red
        }
    }
}

# Main script execution
try {
    # Ensure winget is installed
    Install-Winget

    # Install the applications
    Install-Apps -appList $apps
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
