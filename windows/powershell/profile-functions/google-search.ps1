# Function name is used to call the function after importing this script
Function gg
{
<# .Synopsis
    Open Chrome browser and search for the [-SearchString] argument. 
    If [-SearchString] not provided, defaults to clipboard contents.
    Requires Google Chrome browser to be installed with "chrome.exe" in the system path.
    Example usage:	
        gg "your search terms"
#>
    param (
        [parameter(mandatory=$false, Position=0)] `
        [String]$SearchString
    )
    process {
        if (!$SearchString){
            $SearchString = Get-Clipboard;
        }
        $URL = $SearchString -replace ' ','+';
        $URL = "https://www.google.com/search?q=" + $URL;
        echo ("Searching Google for <" + $SearchString + ">...");
        start chrome.exe $URL;
    }
}

