<#
    Title: Windows Bulk Folder Creator v1.1
    Copyright© 2024 Magdy Aloxory. All rights reserved.
    Contact: maloxory@gmail.com
#>

# Check if the script is running with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch the script with administrator privileges
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

# Function to center text
function CenterText {
    param (
        [string]$text,
        [int]$width
    )
    
    $textLength = $text.Length
    $padding = ($width - $textLength) / 2
    return (" " * [math]::Max([math]::Ceiling($padding), 0)) + $text + (" " * [math]::Max([math]::Floor($padding), 0))
}

# Function to create a border
function CreateBorder {
    param (
        [string[]]$lines,
        [int]$width
    )

    $borderLine = "+" + ("-" * $width) + "+"
    $borderedText = @($borderLine)
    foreach ($line in $lines) {
        $borderedText += "|$(CenterText $line $width)|"
    }
    $borderedText += $borderLine
    return $borderedText -join "`n"
}

# Display script information with border
$title = "Windows Bulk Folder Creator (BFC) v1.1"
$copyright = "Copyright 2024 Magdy Aloxory. All rights reserved."
$contact = "Contact: maloxory@gmail.com"
$maxWidth = 50

$infoText = @($title, $copyright, $contact)
$borderedInfo = CreateBorder -lines $infoText -width $maxWidth

Write-Host $borderedInfo -ForegroundColor Cyan


# Prompt user for the base path for the folders
$basePath = Read-Host "Please enter the path to the folder"

# Prompt user for the folder name prefix
$folderNamePrefix = Read-Host "Please enter the folder name prefix"

# Prompt user for the starting index
$startIndex = Read-Host "Please enter the starting index" 
$startIndex = [int]$startIndex

# Prompt user for the ending index
$endIndex = Read-Host "Please enter the ending index"
$endIndex = [int]$endIndex

# Loop to create folders within the specified range
for ($i = $startIndex; $i -le $endIndex; $i++) {
    # Format the folder name
    $folderName = "{0}_{1:D3}" -f $folderNamePrefix, $i
    # Combine the base path with the folder name
    $folderPath = Join-Path -Path $basePath -ChildPath $folderName
    
    # Check if the folder already exists
    if (-Not (Test-Path -Path $folderPath)) {
        # Create the folder
        New-Item -Path $folderPath -ItemType Directory
        Write-Host "Created folder: $folderPath"
    } else {
        Write-Host "Folder already exists: $folderPath"
    }
}

Write-Host "All folders created successfully." -ForegroundColor Green

pause
