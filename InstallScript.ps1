# Define paths
$documentsFolder = [Environment]::GetFolderPath("MyDocuments")
$projectFolder = Join-Path $documentsFolder "MyProject"
$sendToFolder = "$env:APPDATA\Microsoft\Windows\SendTo"
$shortcutPath = Join-Path $sendToFolder "MyProjectShortcut.lnk"

# Create the project folder in Documents
if (-not (Test-Path -Path $projectFolder)) {
    New-Item -ItemType Directory -Path $projectFolder
    Write-Host "Created folder: $projectFolder"
}

# Copy project files to the new folder
$sourceFolder = ".\ProjectFiles"  # Adjust this to your repository's folder structure
Copy-Item -Path $sourceFolder\* -Destination $projectFolder -Recurse -Force
Write-Host "Copied project files to: $projectFolder"

# Create a shortcut in the SendTo menu
$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "$projectFolder\MyExecutable.exe"  # Adjust to your main executable
$shortcut.Description = "Shortcut to My Project"
$shortcut.Save()
Write-Host "Created shortcut in SendTo: $shortcutPath"
