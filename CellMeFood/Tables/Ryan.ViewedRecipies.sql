SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [Ryan].[ViewedRecipies] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[recipeid]       [int] NOT NULL,
		[userid]         [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[ViewedRecipies]
	ADD
	CONSTRAINT [DF_ViewedRecipies_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[ViewedRecipies] SET (LOCK_ESCALATION = TABLE)
GO
