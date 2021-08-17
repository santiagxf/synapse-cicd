CREATE TABLE [dbo].[AdventureWorksDWBuildVersion] (
    [DBVersion]   NVARCHAR (50) NOT NULL,
    [VersionDate] DATETIME      NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([DBVersion]));


GO



GO

