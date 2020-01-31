$token = 'seutokendigitalmed'
# Set the source environment name
$sourceEnvironmentName = 'PX.PLERESNET.AZUL.FRONT'
# Set the new environment name
$newEnvironmentName =  'PX.PLERESNET.CARAMELO.FRONT'

$headers = @{
  "Authorization" = "Bearer $token"
  "Content-type" = "application/json"
}

# get source environment ID
$sourceEnvironmentId = ((Invoke-RestMethod -Uri "https://ci.appveyor.com/api/environments" -Headers $headers -Method Get) | where {$_.name -eq $sourceEnvironmentName}).deploymentEnvironmentId

# get source environment properies
$source = Invoke-RestMethod -Uri "https://ci.appveyor.com/api/environments/$sourceEnvironmentId/settings" -Headers $headers -Method Get

# optionally update name
$source.environment.name = ($newEnvironmentName)

# create new environment with properies from the source
Invoke-RestMethod -Uri 'https://ci.appveyor.com/api/environments' -Headers $headers  -Body ($source.environment | ConvertTo-Json -Depth 10) -Method Post
