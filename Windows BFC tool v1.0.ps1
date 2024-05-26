# Title: Windows Folders Bulk Creation Tool
# Copyright (c) 2024 Magdy Aloxory. All rights reserved.
# Contact: maloxory@gmail.com

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

Write-Host "All folders created successfully."

pause
