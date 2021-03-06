Param(
    [parameter(Mandatory=$true)]
    [string] $production_build_directory, 
    [parameter(Mandatory=$true)]
    [string] $CloudflareAdminEmail, 
    [parameter(Mandatory=$true)]
    [string] $CloudflareApiKey, 
    [parameter(Mandatory=$true)]
    [string] $CloudflareZoneId
);

# Build the website

Read-Host -Prompt ("Initializing production build. This will delete all files in " `
	+ $production_build_directory `
	+ ". Press any key to continue, or ctrl+c to abort")

hugo --cleanDestinationDir `
	--destination $production_build_directory

# Upload the website

Read-Host -prompt ("Initializing git commit and push for all files in " `
	+ $production_build_directory `
	+ ". Press any key to continue or ctrl+c to abort")

git -C $production_build_directory add *
git -C $production_build_directory status

$git_commit_message = Read-Host ("Enter a short commit message, or ctrl+c to abort")

git -C $production_build_directory checkout master 
git -C $production_build_directory commit -a -m $git_commit_message
git -C $production_build_directory push

# Clear the Cloudflare cache
<# Credit to [Niels Swimberghe]
(https://swimburger.net/blog/powershell/powershell-snippet-clearing-cloudflare-cache-with-cloudflares-api) #>

Read-Host -Prompt "About to clear the Cloudflare cache. Press any key to continue, or ctrl+c to abort"

$PurgeCacheUri = "https://api.cloudflare.com/client/v4/zones/$CloudflareZoneId/purge_cache";
$RequestHeader = @{
    'X-Auth-Email' = $CloudflareAdminEmail
    'X-Auth-Key' = $CloudflareApiKey
};
$RequestBody = '{"purge_everything":true}';
Invoke-RestMethod `
    -Uri $PurgeCacheUri `
    -Method Delete `
    -ContentType  "application/json" `
    -Headers $requestHeader `
    -Body $RequestBody
