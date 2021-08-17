CREATE TABLE [dbo].[DimEmployee] (
    [EmployeeKey]                          INT            NOT NULL,
    [ParentEmployeeKey]                    INT            NULL,
    [EmployeeNationalIDAlternateKey]       NVARCHAR (15)  NULL,
    [ParentEmployeeNationalIDAlternateKey] NVARCHAR (15)  NULL,
    [SalesTerritoryKey]                    INT            NULL,
    [FirstName]                            NVARCHAR (50)  NOT NULL,
    [LastName]                             NVARCHAR (50)  NOT NULL,
    [MiddleName]                           NVARCHAR (50)  NULL,
    [NameStyle]                            BIT            NOT NULL,
    [Title]                                NVARCHAR (50)  NULL,
    [HireDate]                             DATE           NULL,
    [BirthDate]                            DATE           NULL,
    [LoginID]                              NVARCHAR (256) NULL,
    [EmailAddress]                         NVARCHAR (50)  NULL,
    [Phone]                                NVARCHAR (25)  NULL,
    [MaritalStatus]                        NCHAR (1)      NULL,
    [EmergencyContactName]                 NVARCHAR (50)  NULL,
    [EmergencyContactPhone]                NVARCHAR (25)  NULL,
    [SalariedFlag]                         BIT            NULL,
    [Gender]                               NCHAR (1)      NULL,
    [PayFrequency]                         TINYINT        NULL,
    [BaseRate]                             MONEY          NULL,
    [VacationHours]                        SMALLINT       NULL,
    [SickLeaveHours]                       SMALLINT       NULL,
    [CurrentFlag]                          BIT            NOT NULL,
    [SalesPersonFlag]                      BIT            NOT NULL,
    [DepartmentName]                       NVARCHAR (50)  NULL,
    [StartDate]                            DATE           NULL,
    [EndDate]                              DATE           NULL,
    [Status]                               NVARCHAR (50)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([EmployeeKey]));


GO



GO

