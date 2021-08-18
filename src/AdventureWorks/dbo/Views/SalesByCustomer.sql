CREATE VIEW [SalesByCustomer]
AS SELECT fis.SalesAmount, dst.Gender, dst.NumberCarsOwned, dst.YearlyIncome AS CustomerYearlyIncome, dst.TotalChildren
      FROM FactInternetSales AS fis
      LEFT OUTER JOIN DimCustomer AS dst
      ON (fis.CustomerKey=dst.CustomerKey);

GO

