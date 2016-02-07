SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Jokes] (
		[Auto]             [float] NULL,
		[JokeCategory]     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[JokeName]         [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Joke]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[length]           AS (len([joke]))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_DCh_616_615_Jokes]
	ON [dbo].[Jokes] ([Auto])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Jokes] SET (LOCK_ESCALATION = TABLE)
GO
