SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Regions] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[country]        [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[region]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Regions]
	ADD
	CONSTRAINT [DF_Regions_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Regions] SET (LOCK_ESCALATION = TABLE)
GO
