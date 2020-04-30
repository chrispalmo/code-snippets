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
function server {py -m simpleHTTPServer}

# Web Apps

## Utilities
function mail {start chrome.exe "https://mail.google.com/"}
function calendar {start chrome.exe "https://calendar.google.com/calendar/"}
function sheets {start chrome.exe "https://docs.google.com/spreadsheets/"}
function slides {start chrome.exe "https://docs.google.com/presentation/"}
function docs {start chrome.exe "https://docs.google.com/document"}

## Dev
function github {start chrome.exe "http://github.com/chrispalmo/"}
function stackoverflow {start chrome.exe "https://stackoverflow.com/"}

## Comms
function messenger {start chrome.exe "https://www.messenger.com/"}
function twitter {start chrome.exe "https://twitter.com/"}
function hootsuite {start chrome.exe "https://hootsuite.com/dashboard#/streams"}

## News
function ii {start chrome.exe "https://www.intelligentinvestor.com.au/identity/logon?returnUrl=%2F&prefix=2"}
function reddit {start chrome.exe "https://www.reddit.com/"}
function ychn {start chrome.exe "https://news.ycombinator.com/"}
function youtube {start chrome.exe "https://www.youtube.com/"}

# General Folders
function dev {cd "~\dev\"}
function dropbox {cd "~\dropbox"}
function profile {cd "~\Documents\WindowsPowerShell\"}
function desk {cd "~\Desktop\"}
function drawer {cd "~\Dropbox\desk-drawer"}

# Navigate to the default startup folder
dev

$test123 = "hello world"
