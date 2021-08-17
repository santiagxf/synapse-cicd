CREATE TABLE [dbo].[DimDepartmentGroup] (
    [DepartmentGroupKey]       INT           NOT NULL,
    [ParentDepartmentGroupKey] INT           NULL,
    [DepartmentGroupName]      NVARCHAR (50) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([DepartmentGroupKey]));


GO



GO

