CREATE TABLE [dbo].[DimScenario] (
    [ScenarioKey]  INT           NOT NULL,
    [ScenarioName] NVARCHAR (50) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([ScenarioKey]));


GO



GO

