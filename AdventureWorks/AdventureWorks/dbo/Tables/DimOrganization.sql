CREATE TABLE [dbo].[DimOrganization] (
    [OrganizationKey]       INT           NOT NULL,
    [ParentOrganizationKey] INT           NULL,
    [PercentageOfOwnership] NVARCHAR (16) NULL,
    [OrganizationName]      NVARCHAR (50) NULL,
    [CurrencyKey]           INT           NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([OrganizationKey]));


GO



GO

