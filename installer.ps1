# Introductory message
$line = "------------------------------------------------------------------------------"
Write-Host $line
Write-Host "# This script will install the following applications:" -ForegroundColor Cyan
Write-Host $line

# Define application list
$apps = @(
    "Google Chrome",
    "Git",
    "Notepad++",
    "Sublime Text",
    "Visual Studio Code",
    "Python",
    "Node.js",
    "DBeaver",
    "GitHub Desktop",
    "PyCharm Community",
    "Eclipse IDE for Java",
    "XAMPP",
    "Scratch",
    "Screen Builder",
    "Veyon Client",
    "WordPress"
)

# Display the list with better formatting
foreach ($app in $apps) {
    Write-Host ("- " + $app) -ForegroundColor Green
}
Write-Host $line
Write-Host "# If you have any issues, please contact support: support@digitalschool.tech" -ForegroundColor Yellow
Write-Host $line
Write-Host "Press (Y) to continue, or (C) to cancel." -ForegroundColor Magenta

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
        "notepadplusplus.install",
        "git",
        "winrar",
        "vscode",
        "python312",
        "nodejs.install",
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
        choco install $package -y --force --no-progress
    }

    Write-Host "Installing Octoparse..."
    
    Write-Host "Installing Octoparse..."
    try {
	$octoparseUrl = "https://download.octoparse.bazhuayu.com/client/en-US/win/Octoparse%20Setup%208.7.2.exe"  # Update URL if needed
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

    
    # Step 4: Download and extract WordPress
    Write-Host "Downloading and setting up WordPress..."
    try {
        $wordpressUrl = "https://wordpress.org/latest.zip"
        $zipPath = "C:\temp\wordpress.zip"
        $extractPath = "C:\xampp\htdocs"

        # Create C:\temp if it doesn't exist (redundant check but safe)
        if (-not (Test-Path "C:\temp")) {
            New-Item -ItemType Directory -Path "C:\temp" | Out-Null
            Write-Host "Created C:\temp directory."
        }

        # Download the WordPress ZIP file
        Write-Host "Downloading WordPress from $wordpressUrl..."
        Invoke-WebRequest -Uri $wordpressUrl -OutFile $zipPath

        # Create htdocs directory if it doesn't exist
        if (-not (Test-Path $extractPath)) {
            New-Item -ItemType Directory -Path $extractPath | Out-Null
            Write-Host "Created $extractPath directory."
        }

        # Extract the ZIP file to htdocs
        Write-Host "Extracting WordPress to $extractPath..."
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $extractPath)

        # Clean up the ZIP file
        Remove-Item -Path $zipPath -Force
        Write-Host "WordPress has been extracted to $extractPath. Please proceed with manual installation via http://localhost after starting XAMPP."
    } catch {
        Write-Host "Failed to download or extract WordPress: $_"
        Write-Host "Please download WordPress manually from https://wordpress.org/latest.zip and extract it to C:\xampp\htdocs"
    }

    Write-Host "All installations completed."
} else {
    Write-Host "Installation cancelled by user."
}

