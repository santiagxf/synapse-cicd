CREATE TABLE [dbo].[DimProduct] (
    [ProductKey]            INT            NOT NULL,
    [ProductAlternateKey]   NVARCHAR (25)  NULL,
    [ProductSubcategoryKey] INT            NULL,
    [WeightUnitMeasureCode] NCHAR (3)      NULL,
    [SizeUnitMeasureCode]   NCHAR (3)      NULL,
    [EnglishProductName]    NVARCHAR (50)  NOT NULL,
    [SpanishProductName]    NVARCHAR (50)  NULL,
    [FrenchProductName]     NVARCHAR (50)  NULL,
    [StandardCost]          MONEY          NULL,
    [FinishedGoodsFlag]     BIT            NOT NULL,
    [Color]                 NVARCHAR (15)  NOT NULL,
    [SafetyStockLevel]      SMALLINT       NULL,
    [ReorderPoint]          SMALLINT       NULL,
    [ListPrice]             MONEY          NULL,
    [Size]                  NVARCHAR (50)  NULL,
    [SizeRange]             NVARCHAR (50)  NULL,
    [Weight]                FLOAT (53)     NULL,
    [DaysToManufacture]     INT            NULL,
    [ProductLine]           NCHAR (2)      NULL,
    [DealerPrice]           MONEY          NULL,
    [Class]                 NCHAR (2)      NULL,
    [Style]                 NCHAR (2)      NULL,
    [ModelName]             NVARCHAR (50)  NULL,
    [EnglishDescription]    NVARCHAR (400) NULL,
    [FrenchDescription]     NVARCHAR (400) NULL,
    [ChineseDescription]    NVARCHAR (400) NULL,
    [ArabicDescription]     NVARCHAR (400) NULL,
    [HebrewDescription]     NVARCHAR (400) NULL,
    [ThaiDescription]       NVARCHAR (400) NULL,
    [GermanDescription]     NVARCHAR (400) NULL,
    [JapaneseDescription]   NVARCHAR (400) NULL,
    [TurkishDescription]    NVARCHAR (400) NULL,
    [StartDate]             DATETIME       NULL,
    [EndDate]               DATETIME       NULL,
    [Status]                NVARCHAR (7)   NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ProductKey]));


GO



GO

