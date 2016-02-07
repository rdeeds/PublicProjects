SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lottery] (
		[GameType]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DrawDate]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Numbers]        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Multiplier]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Column 4]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lottery] SET (LOCK_ESCALATION = TABLE)
GO
