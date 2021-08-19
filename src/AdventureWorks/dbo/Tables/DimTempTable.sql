CREATE TABLE [dbo].[DimTempTable] (
    [id]       INT          NOT NULL,
    [lastName] VARCHAR (20) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([id]));


GO



GO

