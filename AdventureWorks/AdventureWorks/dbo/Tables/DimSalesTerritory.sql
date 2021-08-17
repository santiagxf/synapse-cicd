CREATE TABLE [dbo].[DimSalesTerritory] (
    [SalesTerritoryKey]          INT           NOT NULL,
    [SalesTerritoryAlternateKey] INT           NULL,
    [SalesTerritoryRegion]       NVARCHAR (50) NOT NULL,
    [SalesTerritoryCountry]      NVARCHAR (50) NOT NULL,
    [SalesTerritoryGroup]        NVARCHAR (50) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([SalesTerritoryKey]));


GO



GO

