# Show current directory (instead of entire path) in prompt:
Function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "$p> "
}

# Import custom powershell scripts
$custom_script_dir = "~\dev\code-snippets\powershell\profile-functions\" 
Write-Output `
	("*** Importing all .ps1 modules from " `
	+ $custom_script_dir + `
	" ***")
Write-Output ""
Get-ChildItem `
	$custom_script_dir `
	-Filter *.ps1 | `
	Foreach-Object `
	{ Import-Module ($custom_script_dir + $_) }

# Quick actions
function sps {start powershell}
function spse {start powershell; exit}

# Web Apps
function mail {start chrome.exe "https://mail.google.com/"}
function calendar {start chrome.exe "https://calendar.google.com/calendar/"}
function sheets {start chrome.exe "https://docs.google.com/spreadsheets/"}
function slides {start chrome.exe "https://docs.google.com/presentation/"}
function docs {start chrome.exe "https://docs.google.com/document"}

# Folders
function dev {cd "~\dev\"}
function dropbox {cd "~\dropbox"}
function profile {cd "~\Documents\WindowsPowerShell\"}
function desk {cd "~\Desktop\"}
function drawer {cd "~\Dropbox\desk-drawer"}

# Navigate to the default startup folder
dev
