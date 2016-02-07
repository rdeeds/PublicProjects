SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trivia2] (
		[questionID]        [int] IDENTITY(1, 1) NOT NULL,
		[question]          [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AnswerA]           [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerB]           [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerC]           [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AnswerD]           [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[correctAnswer]     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[answerNumb]        AS ([ryan].[fd_trivia_answer]([answera],[answerb],[answerc],[answerd],[correctanswer]))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[trivia2] SET (LOCK_ESCALATION = TABLE)
GO
