SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[TriviaHistory] (
		[id]                [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]        [smalldatetime] NOT NULL,
		[usernumber]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[questionid]        [int] NOT NULL,
		[correctanswer]     [int] NOT NULL,
		[userinput]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[batchid]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[triviacount]       [int] NULL,
		[correct]           AS ([ryan].[comp]([correctanswer],[userinput]))
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[TriviaHistory]
	ADD
	CONSTRAINT [DF_TriviaHistory_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[TriviaHistory] SET (LOCK_ESCALATION = TABLE)
GO
