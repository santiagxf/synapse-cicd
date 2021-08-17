CREATE TABLE [dbo].[DimProductCategory] (
    [ProductCategoryKey]          INT           NOT NULL,
    [ProductCategoryAlternateKey] INT           NULL,
    [EnglishProductCategoryName]  NVARCHAR (50) NOT NULL,
    [SpanishProductCategoryName]  NVARCHAR (50) NOT NULL,
    [FrenchProductCategoryName]   NVARCHAR (50) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ProductCategoryKey]));


GO



GO

