CREATE TABLE [dbo].[DimSalesReason] (
    [SalesReasonKey]          INT           NOT NULL,
    [SalesReasonAlternateKey] INT           NOT NULL,
    [SalesReasonName]         NVARCHAR (50) NOT NULL,
    [SalesReasonReasonType]   NVARCHAR (50) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([SalesReasonKey]));


GO



GO

