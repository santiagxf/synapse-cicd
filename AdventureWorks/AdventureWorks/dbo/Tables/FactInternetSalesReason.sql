CREATE TABLE [dbo].[FactInternetSalesReason] (
    [SalesOrderNumber]     NVARCHAR (20) NOT NULL,
    [SalesOrderLineNumber] TINYINT       NOT NULL,
    [SalesReasonKey]       INT           NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([SalesOrderNumber]));


GO



GO

