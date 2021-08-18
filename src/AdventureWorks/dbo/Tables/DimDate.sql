CREATE TABLE [dbo].[DimDate] (
    [DateKey]              INT           NOT NULL,
    [FullDateAlternateKey] DATE          NOT NULL,
    [DayNumberOfWeek]      TINYINT       NOT NULL,
    [EnglishDayNameOfWeek] NVARCHAR (10) NOT NULL,
    [SpanishDayNameOfWeek] NVARCHAR (10) NOT NULL,
    [FrenchDayNameOfWeek]  NVARCHAR (10) NOT NULL,
    [DayNumberOfMonth]     TINYINT       NOT NULL,
    [DayNumberOfYear]      SMALLINT      NOT NULL,
    [WeekNumberOfYear]     TINYINT       NOT NULL,
    [EnglishMonthName]     NVARCHAR (10) NOT NULL,
    [SpanishMonthName]     NVARCHAR (10) NOT NULL,
    [FrenchMonthName]      NVARCHAR (10) NOT NULL,
    [MonthNumberOfYear]    TINYINT       NOT NULL,
    [CalendarQuarter]      TINYINT       NOT NULL,
    [CalendarYear]         SMALLINT      NOT NULL,
    [CalendarSemester]     TINYINT       NOT NULL,
    [FiscalQuarter]        TINYINT       NOT NULL,
    [FiscalYear]           SMALLINT      NOT NULL,
    [FiscalSemester]       TINYINT       NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([DateKey]));


GO



GO

