SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [Ryan].[MeattoRecipe] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NULL,
		[meatid]         [int] NULL,
		[recipeid]       [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[MeattoRecipe]
	ADD
	CONSTRAINT [DF_MeattoRecipe_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[MeattoRecipe] SET (LOCK_ESCALATION = TABLE)
GO
