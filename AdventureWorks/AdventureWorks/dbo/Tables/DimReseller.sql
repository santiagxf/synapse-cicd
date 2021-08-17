CREATE TABLE [dbo].[DimReseller] (
    [ResellerKey]          INT           NOT NULL,
    [GeographyKey]         INT           NULL,
    [ResellerAlternateKey] NVARCHAR (15) NULL,
    [Phone]                NVARCHAR (25) NULL,
    [BusinessType]         VARCHAR (20)  NOT NULL,
    [ResellerName]         NVARCHAR (50) NOT NULL,
    [NumberEmployees]      INT           NULL,
    [OrderFrequency]       CHAR (1)      NULL,
    [OrderMonth]           TINYINT       NULL,
    [FirstOrderYear]       INT           NULL,
    [LastOrderYear]        INT           NULL,
    [ProductLine]          NVARCHAR (50) NULL,
    [AddressLine1]         NVARCHAR (60) NULL,
    [AddressLine2]         NVARCHAR (60) NULL,
    [AnnualSales]          MONEY         NULL,
    [BankName]             NVARCHAR (50) NULL,
    [MinPaymentType]       TINYINT       NULL,
    [MinPaymentAmount]     MONEY         NULL,
    [AnnualRevenue]        MONEY         NULL,
    [YearOpened]           INT           NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ResellerKey]));


GO



GO

