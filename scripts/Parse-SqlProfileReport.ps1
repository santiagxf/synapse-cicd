param
(
    [Parameter(Mandatory)]
    [ValidateSet("dev", "qa", "prod", "sandbox")]
    [String]$Environment,
    [Parameter(Mandatory)]
    [String]$SqlPackageReport,
    [String]$OutputFilePath  = "sql_package_summary.MD"
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

Write-Debug 'Creating report header'
$Environment = $Environment.ToUpper()
Add-Content -Path $OutputFilePath -Value "# SQL Pool changes' report for $Environment"
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
        Write-Host "::error file=$SqlPackageReport::" $_.Issue.Value
    }
}
else {
    Add-Content -Path $OutputFilePath -Value " - No data issues where detected"
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
        Write-Host "::warning file=$SqlPackageReport::Potential harmful operation detected: " + $_.Name
    }
}
else {
    Add-Content -Path $OutputFilePath -Value " - No harmul operations were detected in the solution"
}

Write-Debug 'Reading operations'
Add-Content -Path $OutputFilePath -Value "## Changeset"
Add-Content -Path $OutputFilePath -Value "This is the list of operations that will be performed in the target database according to its current state.`r`n<br />`r`n"

$operations = $report.DeploymentReport.Operations.Operation
if ($operations){
    $operations | group -Property Name | Select -ExpandProperty Group | foreach {
        $operation = $_.Name

        "### Summary of changes: {0}" -f $operation | Add-Content -Path $OutputFilePath
        "| Operaton | Object type | Name or reference | Issues |" | Add-Content -Path $OutputFilePath
        "| -------- | ----------- | ----------------- | ------ |" | Add-Content -Path $OutputFilePath

        $_.Item | foreach { Write-TableOperation -operation $operation -item $_ -OutputFilePath $OutputFilePath }
    }
}
else {
    Add-Content -Path $OutputFilePath -Value " - No changes will be introduced"
}