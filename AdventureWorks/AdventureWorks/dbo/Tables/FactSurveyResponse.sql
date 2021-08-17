CREATE TABLE [dbo].[FactSurveyResponse] (
    [SurveyResponseKey]             INT           NOT NULL,
    [DateKey]                       INT           NOT NULL,
    [CustomerKey]                   INT           NOT NULL,
    [ProductCategoryKey]            INT           NOT NULL,
    [EnglishProductCategoryName]    NVARCHAR (50) NOT NULL,
    [ProductSubcategoryKey]         INT           NOT NULL,
    [EnglishProductSubcategoryName] NVARCHAR (50) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([CustomerKey]));


GO



GO

