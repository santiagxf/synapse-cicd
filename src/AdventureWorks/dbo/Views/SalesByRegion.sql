CREATE VIEW [SalesByRegion]
AS SELECT fis.SalesAmount, dst.PostalCode, dst.StateProvinceCode
      FROM FactInternetSales AS fis
      LEFT OUTER JOIN DimGeography AS dst
      ON (fis.SalesTerritoryKey=dst.SalesTerritoryKey);

GO

