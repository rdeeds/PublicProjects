SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [rebecca].[WordsinIngrediantsTEMP] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[recipeid]       [int] NOT NULL,
		[word]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [rebecca].[WordsinIngrediantsTEMP]
	ADD
	CONSTRAINT [DF_WordsinIngrediants_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [rebecca].[WordsinIngrediantsTEMP] SET (LOCK_ESCALATION = TABLE)
GO
