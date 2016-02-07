SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[backuprecipe] (
		[id]                 [int] IDENTITY(1, 1) NOT NULL,
		[RecipeCounter]      [int] NOT NULL,
		[RecipeLanguage]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RecipeCountry]      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RecipeType]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Name]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Author]             [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Ingredients]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Instructions]       [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Picture]            [image] NULL,
		[Serves]             [smallint] NULL,
		[Notes]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FavoriteDish]       [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[backuprecipe] SET (LOCK_ESCALATION = TABLE)
GO
