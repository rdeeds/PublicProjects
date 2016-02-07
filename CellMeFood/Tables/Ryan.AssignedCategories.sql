SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [Ryan].[AssignedCategories] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[catid]          [int] NOT NULL,
		[recipeid]       [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[AssignedCategories]
	ADD
	CONSTRAINT [DF_AssignedCategories_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[AssignedCategories] SET (LOCK_ESCALATION = TABLE)
GO
