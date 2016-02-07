SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SearchRecipe] (
		[Name]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Ingredients]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Serves]          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SearchRecipe] SET (LOCK_ESCALATION = TABLE)
GO
