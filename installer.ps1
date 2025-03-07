# Introductory message
Write-Host "------------------------------------------------------------------------------"
Write-Host "# This script will install the following apps"
Write-Host "# Google Chrome"
Write-Host "# Git"
Write-Host "# NotePad ++"
Write-Host "# Sublime Text"
Write-Host "# Visual Studio Code"
Write-Host "# Python"
Write-Host "# NodeJS"
Write-Host "# DBeaver"
Write-Host "# Github Desktop"
Write-Host "# Pycharm Community"
Write-Host "# Eclipse Ide for Java"
Write-Host "# Xampp"
Write-Host "# Scratch"
Write-Host "# Screen Builder"
Write-Host "# Veyon Client"
Write-Host "------------------------------------------------------------------------------"
Write-Host ""
Write-Host "# If you have issue please contact us: support@digitalschool.tech"
Write-Host "------------------------------------------------------------------------------"
Write-Host "If you want to continue press (Y), to cancel press (C)"

# Get user input and proceed only if Y is pressed
$choice = Read-Host
if ($choice -eq "Y" -or $choice -eq "y") {
    # Ensure Chocolatey is installed
    if (-not (Test-Path "$env:ProgramData\chocolatey")) {
        Write-Host "Chocolatey is not installed. Installing..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    # Install packages
    $packages = @(
        "googlechrome",
        "notepadplusplus",
        "git",
        "winrar",
        "visualstudiocode",
        "python312",
        "nodejs",
        "dbeaver",
        "github-desktop",
        "sublimetext3",
        "pycharm-community",
        "veyon",
        "eclipse-java-oxygen",
        "xampp-81",
        "scratch",
        "scenebuilder"
    )

    foreach ($package in $packages) {
        Write-Host "Installing $package..."
        choco install $package -y --no-progress
    }

    Write-Host "Installing Octoparse..."
    try {
        $octoparseUrl = "https://www.octoparse.com/download/octoparse_setup.exe"  # Update URL if needed
        $output = "C:\temp\octoparse_setup.exe"
        if (-not (Test-Path "C:\temp")) {
            New-Item -ItemType Directory -Path "C:\temp" | Out-Null
        }
        Write-Host "Downloading Octoparse installer..."
        Invoke-WebRequest -Uri $octoparseUrl -OutFile $output
        Write-Host "Running Octoparse installer (manual interaction may be required)..."
        Start-Process -FilePath $output -Wait
        Write-Host "Octoparse installation initiated. Please complete any prompts."
    } catch {
        Write-Host "Failed to download or run Octoparse installer: $_"
        Write-Host "Please download and install Octoparse manually from https://www.octoparse.com/download"
    }

    Write-Host "All installations completed."
} else {
    Write-Host "Installation cancelled by user."
}
