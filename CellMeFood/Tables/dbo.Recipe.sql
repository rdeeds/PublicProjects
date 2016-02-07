SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Recipe] (
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
		[FavoriteDish]       [bit] NOT NULL,
		[fast]               [bit] NULL,
		[Cheap]              [bit] NULL,
		[Healthy]            [bit] NULL,
		[Active]             [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Recipe]
	ADD
	CONSTRAINT [PK_Recipe]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_DCh_1537_1536_Recipe]
	ON [dbo].[Recipe] ([RecipeType])
	INCLUDE ([id], [RecipeCountry])
	ON [PRIMARY]
GO
CREATE FULLTEXT INDEX ON [dbo].[Recipe]
	([RecipeCountry] LANGUAGE 1033, [RecipeType] LANGUAGE 1033, [Name] LANGUAGE 1033, [Ingredients] LANGUAGE 1033, [Instructions] LANGUAGE 1033, [Notes] LANGUAGE 1033)
	KEY INDEX [PK_Recipe]
	ON (FILEGROUP [PRIMARY], [FullTextRecipes])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[Recipe] SET (LOCK_ESCALATION = TABLE)
GO
