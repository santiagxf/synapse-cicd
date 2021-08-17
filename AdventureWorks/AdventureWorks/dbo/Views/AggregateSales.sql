CREATE VIEW [AggregateSales]
AS SELECT FIS.SalesAmount, DG.PostalCode, DC.YearlyIncome AS CustomerIncome,  DD.FullDateAlternateKey AS OrderDate
		FROM FactInternetSales AS FIS  
			   JOIN DimCustomer AS DC 
			   ON (FIS.CustomerKey = DC.CustomerKey)
			   JOIN DimDate AS DD
			   ON (FIS.OrderDateKey = DD.DateKey)
			   JOIN DimGeography AS DG 
					 ON (DC.GeographyKey = DG.GeographyKey);

GO

