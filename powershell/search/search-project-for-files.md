# List all files in a project, and their respective paths:

### OPTION 1 - list all files respective of filetype:
```
dir -r -Attributes !Directory | Select FullName
```

### OPTION 2 - exclude certain filetypes:

```
dir -r -exclude *pdf, *.jpg, *.png, *.dwg, *.bak, *.txt, *.lnk, *.log -Attributes !Directory | Select FullName
```
 
### OPTION 3 - include only certain filetypes:

```
dir -r -include *pdf, *dwg -Attributes !Directory | Select FullName
```

### Export to CSV
Append the following suffix ("pipe" the output into the Export-Csv function and specify a filename for the output):
```
{any_powershell_command_with_output} | Export-Csv "file-search-results.csv"
``` 