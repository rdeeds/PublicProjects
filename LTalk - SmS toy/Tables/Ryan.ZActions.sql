SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[ZActions] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[event]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[eventtype]      [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[ZActions]
	ADD
	CONSTRAINT [DF_ZActions_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[ZActions] SET (LOCK_ESCALATION = TABLE)
GO
