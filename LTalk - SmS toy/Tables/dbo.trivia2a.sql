SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trivia2a] (
		[question]          [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerA]           [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerB]           [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerC]           [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerD]           [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[correctAnswer]     [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[trivia2a] SET (LOCK_ESCALATION = TABLE)
GO
