SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[questions_space_exploration] (
		[question]     [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[phrase]       [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerA]      [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerB]      [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerC]      [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[questions_space_exploration] SET (LOCK_ESCALATION = TABLE)
GO
