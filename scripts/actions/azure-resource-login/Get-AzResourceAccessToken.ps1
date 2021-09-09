param
(
    [Parameter(Mandatory)]
    [String]$ResourceUrl,
    [String]$ResourceTypeName= "Arm"
)

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name Az.Accounts -AllowClobber

$context = Get-AzContext
$resourceToken = (Get-AzAccessToken -ResourceUrl $ResourceUrl -DefaultProfile $context).Token

return $resourceToken