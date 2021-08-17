CREATE VIEW [SalesByCategory]
AS SELECT fis.SalesAmount, dst.ProductLine
      FROM FactInternetSales AS fis
      LEFT OUTER JOIN DimProduct AS dst
      ON (fis.ProductKey=dst.ProductKey);

GO

