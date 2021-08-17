CREATE TABLE [dbo].[FactSalesQuota] (
    [SalesQuotaKey]    INT      NOT NULL,
    [EmployeeKey]      INT      NOT NULL,
    [DateKey]          INT      NOT NULL,
    [CalendarYear]     SMALLINT NOT NULL,
    [CalendarQuarter]  TINYINT  NOT NULL,
    [SalesAmountQuota] MONEY    NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([SalesQuotaKey]));


GO



GO

