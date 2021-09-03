# Custom actions
The following custom actions are available in this repository:


| Action | Description | Outputs |
| --- | ----------- | ------------- |
| [<nobr>azure-resource-login</nobr>](#azure-resource-login) | Provides a convenient way to login into an Azure Resource using a Service Principal | Authentication token |
| [<nobr>dotnet-data-build</nobr>](#dotnet-data-build) | Builds a `Visual Studio Database Projects` and generates the asociated `dacpac` | Built artifact(s) |
| [<nobr>run-sqlpackage</nobr>](#run-sqlpackage) | Runs `SqlPackage` command line utility | Depends on the Action executed |
| [<nobr>synapse-snapshot</nobr>](#synapse-snapshot) | Creates a restore point in either a Synapse Analytics Workspace or an Azure SQL Database | None |
| [<nobr>validate-sqlpackage</nobr>](#validate-sqlpackage) | Performs a validation on a `Deployment Report` generated using `SqlPackage`. | A MarkDown file with the summary of the validations |


## azure-resource-login

> Provides a convenient way to login into an Azure Resource using a Service Principal.

Parameters:
- **creds:** The Azure Active Directory Service Principal credentials to be used in the login process. This information has to be provided in the form of a JSON string as indicated in [this example](https://github.com/marketplace/actions/azure-login#configure-deployment-credentials). You can use `${{ secrets.AZURE_CREDENTIALS }}` to store the credentials in a secret named `AZURE_CREDENTIALS`.
- **resource-url:** The cannonical URL of the resource you want to authenticate for. For instance, for Azure Databases you can indicate `https://database.windows.net`.
- **resource-type-name:** The type of the resource you want to authenticate for. If you indicate `resource-url` this parameter can be ignored. Supported values: `AadGraph`, `AnalysisServices`, `Arm` (default), `Attestation`, `Batch`, `DataLake`, `KeyVault`, `OperationalInsights`, `ResourceManager`, `Storage`, `Synapse`.

Outputs:
 - **token [string]:** Authentication Token


## dotnet-data-build

> Compiles and build a dotnet core solution with data components.

Parameters:
 - **configuration:** Indicates the build configuration to use. Posible values are `Release` (default) or `Debug`.
 - **solution:** The path where to look for the solution (`.sln` or `.csproj`) to compile and build. Wildcard paths are supported. When multiple solutions are match by a wildcard expression, all of them are build and placed on `outputpath`.
 - **outputpath:** The path where to store the compiled projects (`.dacpac`).

## run-sqlpackage

> Runs `SqlPackage` command line utility.

Parameters:
 - **action:** Action parameter to run with `SqlPackage`. Supported values: `Publish`, `DeployReport`, `DriftReport`, `Script`.
 - **sourcepath:** The path where to look for the `dacpac` file. Wildcard paths are supported. When multiple files are matched by the expression, `SqlPackage` is executed on each of them.
 - **profile:** The profile file path to use during the execution of `SqlPackage`. This file has to be in `XML`. You can generate a sample of this file using Visual Studio'.
 - **database-server:** Database server URL (without protocol) that `SqlPackage` should target. This parameter is optional if the database server is indicated in the publishing profile.
 - **database-name:** The target database name. This parameter is optional if the database name is indicated in the publishing profile.'
 - **authtoken:** The authentication token used to connect to the database, if credentials not indicated in the connection string.
 - **outputpath:** The output folder where assets will be generated if any. When multiple `dacpac` files are matched in `sourcepath`, then multiple files will be generated in the `outputpath`. Files will be named in the following way: `[dacpac_name].[outputfile]`.
 - **outputfile:** The base output file name. The final name of the file will be `[dacpac_name].[outputfile]`

## synapse-snapshot

> Creates a restore point in either a Synapse Analytics Workspace or an Azure SQL Database.

Parameters:
 - **resource-group:** Resource group where the database is located
 - **profile:** The profile file path used to deploy solutions in the target database. This file has to be in `XML` and it is used just to detect the target database server and target database name. This parameter can be ignored if both are indicated on `database-server` and `database-name`.
 - **database-server:** Database server URL (without protocol) to execute the operation on. This parameter is optional if the database server is indicated in the publishing profile.
 - **database-name:** The target database name. This parameter is optional if the database name is indicated in the publishing profile.'
 - **label:** Restore point label. Defaults to the GitHub action run ID.
 - **authtoken:** Authentication token to execute the operation. Use **azure-resource-login** to get it.
 - **synapse-workspace:** `true` if the target database is a Synapse Analytics workspace`

## validate-sqlpackage

> Validates the changes analyzed by a `SqlPackage` and generates a markdown file containing a resume of all the changes, warnings and issues detected. If a data error is found, this action can make the job to fail to prevent continuing the execution.

Parameters:
 - **environment:** Environment identifier to include in the report> Default value is `dev`, referring to a `development` environment. Other options tipically are `prd`, `qa` or `stg`. This parameters doesn't have any other implication.
 - **sqlpackage-report:** The filepath of the report generated by `SqlPackage`. It has extension XML. Wildcard paths are supported. When multiple XML files are matched y the expression, all of them are analyzed, however, a single deployment report is generated combining all the changes.
 - **outputpath:** The output folder where assets will be generated if any.
 - **outputfile:** The output file name, with extension MD'. Default is `deployreport.MD`
 - **haltonerrors:** Indicates if the action should fail when validation errors are found. Defaults to `true`.

Outputs:
 - **ignorable [bool]:** Indicates if the deployment can be ignored since no changes are introduced in the database. It indicates that none of the packages will introduce changes into the target database.
 - **errors [bool]:** Indicates if errors or data issues were found during the analysis. This is useful when `haltOnErrors` is set to `false`, and then, even when the step succeeds, `errors` will be set to `true`.