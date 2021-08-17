CREATE TABLE [dbo].[DimGeography] (
    [GeographyKey]             INT           NOT NULL,
    [City]                     NVARCHAR (30) NULL,
    [StateProvinceCode]        NVARCHAR (3)  NULL,
    [StateProvinceName]        NVARCHAR (50) NULL,
    [CountryRegionCode]        NVARCHAR (3)  NULL,
    [EnglishCountryRegionName] NVARCHAR (50) NULL,
    [SpanishCountryRegionName] NVARCHAR (50) NULL,
    [FrenchCountryRegionName]  NVARCHAR (50) NULL,
    [PostalCode]               NVARCHAR (15) NULL,
    [SalesTerritoryKey]        INT           NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([GeographyKey]));


GO



GO

