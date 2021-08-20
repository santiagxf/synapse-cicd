# Azure Synapse CI/CD pipeline with GitHub Workflows

This repository contains an implementation of a CI/CD pipeline using GitHub Workflows to package, validate and integrate changes into a Synapse Database.

## Implementation

This CI/CD implementation relies on the use of SqlPackage and Visual Studio Database Projects.

### About SqlPackate

SqlPackage.exe is a command-line utility that automates the versioning, validation and deployment of database projects for SQL Server, Azure SQL Database and Azure Synapse. It provides a convenient way to administer the evolution of the schema of a database. 

## CI and CD workflows

Two workflows are available in this repository:
 - CI
 - CD
### Validations

The CI job will perform 3 steps to validate the changes in the schema that are being introduced:

![](docs/images/validations.png)

 1) **Identifying proposed changes:** The database schema specified in the DACPAC file is compared with the current state of the database and a delta is computed. This delta will contain all the changes that had to be done on `target` to match the DACPAC specification.
 2) **Validating proposed changes:** The computed changes are now parsed to identify how they may affect the deployment in some way. Changes are categorized in 3 categories:
    * **Data issues:** These are changes introduced by the package that will centainly make the deployment to fail and hence need to be resolved before going on. These changes will make the job to fail.
    * **Warnings:** These are changes introduced by the package that may represent a concern in terms of the integrity of the data or a potential data loss. These changes are notified but they will not make the job to fail.
    * **Changes:** there are all the operations that will be performed in the target database in order to move it from it's current version to the version proposed in the DACPAC. 

### How issues or warnings are notified?

Both issues and warnings are logged into the annotation board in GitHub where a detail about the issue is presented for reviewing:

![](docs/images/parse-error.png)
