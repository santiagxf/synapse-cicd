CREATE VIEW [SalesByDate]
AS SELECT fis.SalesAmount, dst.EnglishMonthName, dst.CalendarYear
      FROM FactInternetSales AS fis
      LEFT OUTER JOIN DimDate AS dst
      ON (fis.OrderDateKey=dst.DateKey);

GO

