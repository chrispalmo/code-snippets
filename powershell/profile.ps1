# Show current directory (instead of entire path) in prompt:
Function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "$p> "
}

# Import custom powershell scripts
$custom_script_dir = "PATH_TO_YOUR_CUSTOM_PS1_SCRIPT_DIRECTORY"
Write-Output `
	("*** Importing all .ps1 modules from " `
	+ $custom_script_dir + `
	" ***")
Get-ChildItem `
	$custom_script_dir `
	-Filter *.ps1 | `
	Foreach-Object `
	{ Import-Module ($custom_script_dir + $_) }

# Navigate to the default startup folder
cd "C:\PATH\TO\YOUR\PREFERRED\STARTUP\FOLDER\"

