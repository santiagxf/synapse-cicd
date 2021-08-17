CREATE TABLE [dbo].[DatabaseLog] (
    [DatabaseLogID] INT             NOT NULL,
    [PostTime]      DATETIME        NOT NULL,
    [DatabaseUser]  NVARCHAR (128)  NOT NULL,
    [Event]         NVARCHAR (128)  NOT NULL,
    [Schema]        NVARCHAR (128)  NULL,
    [Object]        NVARCHAR (128)  NULL,
    [TSQL]          NVARCHAR (4000) NOT NULL,
    [TempCol]       NVARCHAR (200)  NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([DatabaseLogID]));


GO



GO

