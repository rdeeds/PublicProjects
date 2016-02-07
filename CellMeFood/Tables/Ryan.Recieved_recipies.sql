SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Recieved_recipies] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[recipeid]       [int] NOT NULL,
		[userid]         [int] NOT NULL,
		[sessionID]      [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Recieved_recipies]
	ADD
	CONSTRAINT [DF_Recieved_recipies_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Recieved_recipies] SET (LOCK_ESCALATION = TABLE)
GO
