SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Vegitables] (
		[id]                [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]        [smalldatetime] NOT NULL,
		[vegitablename]     [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Vegitables]
	ADD
	CONSTRAINT [DF_Vegitables_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Vegitables] SET (LOCK_ESCALATION = TABLE)
GO
