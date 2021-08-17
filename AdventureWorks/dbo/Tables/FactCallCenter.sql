CREATE TABLE [dbo].[FactCallCenter] (
    [FactCallCenterID]    INT           NOT NULL,
    [DateKey]             INT           NOT NULL,
    [WageType]            NVARCHAR (15) NOT NULL,
    [Shift]               NVARCHAR (20) NOT NULL,
    [LevelOneOperators]   SMALLINT      NOT NULL,
    [LevelTwoOperators]   SMALLINT      NOT NULL,
    [TotalOperators]      SMALLINT      NOT NULL,
    [Calls]               INT           NOT NULL,
    [AutomaticResponses]  INT           NOT NULL,
    [Orders]              INT           NOT NULL,
    [IssuesRaised]        SMALLINT      NOT NULL,
    [AverageTimePerIssue] SMALLINT      NOT NULL,
    [ServiceGrade]        FLOAT (53)    NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([FactCallCenterID]));


GO



GO

