# Imports JSON file as $config variable

$config = Get-Content -Raw -Path .\config.json | ConvertFrom-Json

# Ensure double backslashes are used for directory paths in JSON files to assist the Powershell ConvertFrom-Json parser (a single backslash is the escape character).

# Example JSON file below:
< #

{
   'production_build_directory': 'PATH//TO//PRODUCTION//BUILD//DIRECTORY',
   'CloudflareAdminEmail': 'YOUR_CLOUDFLARE_ADMIN_EMAIL',
   'CloudflareApiKey': 'YOUR_CLOUDFLARE_API_KEY',
   'CloudflareZoneId': 'YOUR_CLOUDFLARE_ZONE_ID'
}

# >
