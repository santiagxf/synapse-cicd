param
(
    [Parameter(Mandatory)]
    [String]$ResourceGroup,
    [string]$PublishingProfilePath,
    [string]$DatabaseServer,
    [string]$DatabaseName,
    [Parameter(Mandatory)]
    [String]$AuthToken,
    [Parameter(Mandatory)]
    [String]$Label,
    [Parameter(Mandatory)]
    [bool]$SynapseWorkspace = $true,
    [String]$ApiVersion= "2021-03-01",
    # Target platform where the action is running
    [Parameter(Mandatory)]
    [ValidateSet("github", "devops")]
    [string]$Platform
)

function Log-Debug($args){
    if ($Platform -eq "github") {
        Write-Host "::debug::$args"
    }
    else {
        Write-Host "##[debug] $args"
    }
}

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name Az.Accounts -AllowClobber
Install-Module -Name Az.Sql -AllowClobber

if ($PublishingProfilePath -ne '')
{
    [xml] $profile = Get-Content $PublishingProfilePath
    $connectionString = $profile.Project.PropertyGroup.TargetConnectionString
    $source = [regex]::Match($connectionString, 'Data Source=([^;]+)').Groups[1].Value
    $targetDatabaseName = $profile.Project.PropertyGroup.TargetDatabaseName
}

if ($DatabaseServer -ne '')
{
    $source = $DatabaseServer
    Log-Debug -args "Database server is set to $source"
}

if ($DatabaseName -ne '')
{
    $targetDatabaseName = $DatabaseName
    Log-Debug -args "Database name is set to $databaseName"
}

# Get resource name without the URL
$targetResourceName = $source.Split('.')[0]
Log-Debug -args "Database resource for the operation is $source ($database)"

if ($SynapseWorkspace)
{
    Log-Debug -args "Restore point targets an Azure SQL Pool"

    $subscriptionId = (Get-AzContext).Subscription.Id
    $requestUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$ResourceGroup/providers/Microsoft.Synapse/workspaces/$targetResourceName/sqlPools/$targetDatabaseName/restorePoints?api-version=$ApiVersion"
    $headers = @{
        'Content-Type'='application/json';
        'Authorization'='Bearer ' + $AuthToken 
    }
    $payload = @{
        'restorePointLabel'='$Label'
    }
    
    Log-Debug -args "Calling $requestUrl over POST"
    Invoke-RestMethod -Method Post -Uri $requestUrl -Headers $headers -Body (ConvertTo-Json $payload)
}
else
{
    Log-Debug -args "Restore point targets an Azure SQL Database"

    $creationRequest = New-AzSqlDatabaseRestorePoint `
        -DatabaseName $targetDatabaseName `
        -ServerName $targetResourceName `
        -ResourceGroupName $ResourceGroup `
        -RestorePointLabel $Label

    $waitDelay = 5
    write-host "Waiting for the creation job" -NoNewLine
    while (($creationRequest | Get-AzSqlDatabaseRestorePoint).Status -eq 'InProgress') 
    {
        write-host '.' -NoNewLine
        Start-Sleep $waitDelay
    }

    write-host " [OK]" -ForegroundColor Green
}