CREATE TABLE [dbo].[DimCurrency] (
    [CurrencyKey]          INT           NOT NULL,
    [CurrencyAlternateKey] NCHAR (3)     NOT NULL,
    [CurrencyName]         NVARCHAR (50) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([CurrencyKey]));


GO



GO

