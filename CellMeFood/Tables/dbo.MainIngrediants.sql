SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MainIngrediants] (
		[id]                    [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]            [smalldatetime] NOT NULL,
		[Orderofingrediant]     [int] NOT NULL,
		[ingrediant]            [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[recipeID]              [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MainIngrediants]
	ADD
	CONSTRAINT [PK_MainIngrediants]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MainIngrediants]
	ADD
	CONSTRAINT [DF_MainIngrediants_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
CREATE NONCLUSTERED INDEX [idx_DCh_1431_1430_MainIngrediants]
	ON [dbo].[MainIngrediants] ([recipeID])
	ON [PRIMARY]
GO
CREATE FULLTEXT INDEX ON [dbo].[MainIngrediants]
	([ingrediant] LANGUAGE 1033)
	KEY INDEX [PK_MainIngrediants]
	ON (FILEGROUP [PRIMARY], [FullTextRecipes])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[MainIngrediants] SET (LOCK_ESCALATION = TABLE)
GO
