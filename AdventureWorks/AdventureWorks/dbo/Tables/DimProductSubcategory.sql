CREATE TABLE [dbo].[DimProductSubcategory] (
    [ProductSubcategoryKey]          INT           NOT NULL,
    [ProductSubcategoryAlternateKey] INT           NULL,
    [EnglishProductSubcategoryName]  NVARCHAR (50) NOT NULL,
    [SpanishProductSubcategoryName]  NVARCHAR (50) NOT NULL,
    [FrenchProductSubcategoryName]   NVARCHAR (50) NOT NULL,
    [ProductCategoryKey]             INT           NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ProductSubcategoryKey]));


GO



GO

