param
(
    # The name of the environment the deploy belong to. This is used just inside the report content
    [Parameter(Mandatory)]
    [ValidateSet("dev", "qa", "prod", "sandbox")]
    [String]$Environment,
    # The Deploy Report that was generated with SqlPackage and you want to validate
    [Parameter(Mandatory)]
    [String]$SqlPackageReport,
    # The markdown file name
    [String]$OutputFilePath  = "sql_package_summary.MD",
    # Indicated if the script should throw an exception when an issue is found
    [bool]$HaltOnDataIssues = $true,
    # Target platform where the action is running
    [Parameter(Mandatory)]
    [ValidateSet("github", "devops")]
    [string]$Platform
)

function Write-TableOperation {
    param (
        $operation,
        $item,
        $OutputFilePath
    )

    "| {0} | {1} | {2} | {3} |" -f $operation, $item.Type, $item.Value, $item.Issue.Id | Add-Content -Path $OutputFilePath
}

function Write-TableIssue {
    param (
        $issue,
        $item,
        $OutputFilePath
    )

    "| {0} | {1} | {2} |" -f $issue, $item.Id, $item.Value | Add-Content -Path $OutputFilePath
}

function Log-Debug($args){
    if ($Platform -eq "github") {
        Write-Host "::debug::$args"
    }
    else {
        Write-Host "##[debug] $args"
    }
}

function Log-Info($args, $filename){
    if ($Platform -eq "devops") {
        Write-Host "##vso[task.logissue type=info] $args"
    }
}

function Log-Warning($args, $filename){
    if ($Platform -eq "github") {
        Write-Host "::warning file=$filename::$args"
    }
    else {
        Write-Host "##vso[task.logissue type=warning] $args"
    }
}

function Log-Error($args, $filename){
    if ($Platform -eq "github") {
        Write-Host "::error:: file=$filename::$args"
    }
    else {
        Write-Host "##vso[task.logissue type=error] $args"
    }
}

Log-Debug -args "Writing report for $Environment at $OutputFilePath"

Write-Debug 'Creating report header'
$Environment = $Environment.ToUpper()
$ReportName = [System.IO.Path]::GetFileNameWithoutExtension($SqlPackageReport)

Add-Content -Path $OutputFilePath -Value "# SQL Pool changes' report on $Environment"
Add-Content -Path $OutputFilePath -Value "## Reported for file $ReportName"
Add-Content -Path $OutputFilePath -Value "The following report contains a summary of the changes that will be applied  `
                                          to the targeted database according to the data solution packages. Please review  `
                                          the content of the report to identify if all the operations that will be performed  `
                                          are correct. Some operations may generate issues in the integration database and  `
                                          may require a closer attention."

Write-Debug 'Reading report'
[xml] $report = Get-Content $SqlPackageReport


Write-Debug 'Reading data issues'
Add-Content -Path $OutputFilePath -Value "## Data issues"
Add-Content -Path $OutputFilePath -Value "The following are operations that if performed will make the deployment to fail and hence shall be fixed."

$issues = $report.DeploymentReport.Alerts.Alert | ? -Property Name -EQ 'DataIssue'
if ($issues) {
    $issues | foreach {
        " - {0}" -f $_.Issue.Value | Add-Content -Path $OutputFilePath
        Log-Error -args $_.Issue.Value -filename $SqlPackageReport
    }
}
else {
    Add-Content -Path $OutputFilePath -Value " - No data issues where detected"
    Log-Debug -args "No data issues where detected"
}


Write-Debug 'Reading alerts'
Add-Content -Path $OutputFilePath -Value "## Warnings"
Add-Content -Path $OutputFilePath -Value "The following are operations that if performed will impact other elements in the database. Some of the warning may not represent a problem for the deployment."

$alerts = $report.DeploymentReport.Alerts.Alert | ? -Property Name -NE 'DataIssue'
if ($alerts) {
    $alerts | foreach {
        "| ID | Warning | Involved objects |" | Add-Content -Path $OutputFilePath
        "| -- | ------- | ---------------- |" | Add-Content -Path $OutputFilePath
    } {
        Write-TableIssue -issue $_.Name -item $_.Issue -OutputFilePath $OutputFilePath
        Log-Warning -args "Potential harmful operation detected: $_.Name" -filename $SqlPackageReport
    }
}
else {
    Add-Content -Path $OutputFilePath -Value " - No harmul operations were detected in the solution"
    Log-Debug -args "No harmul operations were detected in the solution"
}

Write-Debug 'Reading operations'
Add-Content -Path $OutputFilePath -Value "## Changeset"
Add-Content -Path $OutputFilePath -Value "This is the list of operations that will be performed in the target database according to its current state.`r`n<br />`r`n"

$operations = $report.DeploymentReport.Operations.Operation
if ($operations)
{
    $ignorable = $false

    $operations | group -Property Name | Select -ExpandProperty Group | foreach {
        $operation = $_.Name

        "### Summary of changes: {0}" -f $operation | Add-Content -Path $OutputFilePath
        "| Operaton | Object type | Name or reference | Issues |" | Add-Content -Path $OutputFilePath
        "| -------- | ----------- | ----------------- | ------ |" | Add-Content -Path $OutputFilePath

        $_.Item | foreach { Write-TableOperation -operation $operation -item $_ -OutputFilePath $OutputFilePath }
    }
}
else {
    $ignorable = $true
    Add-Content -Path $OutputFilePath -Value " - No changes will be introduced"
    Log-Debug -args "No changes will be introduced"
}

if ($issues -And $HaltOnDataIssues)
{
    throw "Parser found errors that prevents deployment to continue." 
}

return @{
    ignorable=$ignorable;
    errors=$issues
}