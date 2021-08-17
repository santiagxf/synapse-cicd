CREATE TABLE [dbo].[FactResellerSales] (
    [ProductKey]            INT           NOT NULL,
    [OrderDateKey]          INT           NOT NULL,
    [DueDateKey]            INT           NOT NULL,
    [ShipDateKey]           INT           NOT NULL,
    [ResellerKey]           INT           NOT NULL,
    [EmployeeKey]           INT           NOT NULL,
    [PromotionKey]          INT           NOT NULL,
    [CurrencyKey]           INT           NOT NULL,
    [SalesTerritoryKey]     INT           NOT NULL,
    [SalesOrderNumber]      NVARCHAR (20) NOT NULL,
    [SalesOrderLineNumber]  TINYINT       NOT NULL,
    [RevisionNumber]        TINYINT       NULL,
    [OrderQuantity]         SMALLINT      NULL,
    [UnitPrice]             MONEY         NULL,
    [ExtendedAmount]        MONEY         NULL,
    [UnitPriceDiscountPct]  FLOAT (53)    NULL,
    [DiscountAmount]        FLOAT (53)    NULL,
    [ProductStandardCost]   MONEY         NULL,
    [TotalProductCost]      MONEY         NULL,
    [SalesAmount]           MONEY         NULL,
    [TaxAmt]                MONEY         NULL,
    [Freight]               MONEY         NULL,
    [CarrierTrackingNumber] NVARCHAR (25) NULL,
    [CustomerPONumber]      NVARCHAR (25) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ProductKey]), PARTITION([OrderDateKey] RANGE RIGHT FOR VALUES (20000101, 20010101, 20020101, 20030101, 20040101, 20050101, 20060101, 20070101, 20080101, 20090101, 20100101, 20110101, 20120101, 20130101, 20140101, 20150101, 20160101, 20170101, 20180101, 20190101, 20200101, 20210101, 20220101, 20230101, 20240101, 20250101, 20260101, 20270101, 20280101, 20290101)));


GO



GO

