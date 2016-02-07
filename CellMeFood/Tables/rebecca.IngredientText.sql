SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [rebecca].[IngredientText] (
		[id]              [int] IDENTITY(1, 1) NOT NULL,
		[ingredients]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [rebecca].[IngredientText] SET (LOCK_ESCALATION = TABLE)
GO
