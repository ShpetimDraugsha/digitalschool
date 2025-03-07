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
