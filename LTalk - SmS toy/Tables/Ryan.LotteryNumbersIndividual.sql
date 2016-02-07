SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[LotteryNumbersIndividual] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[lotteryid]      [int] NOT NULL,
		[position]       [int] NOT NULL,
		[number]         [int] NOT NULL,
		[drawdate]       [smalldatetime] NOT NULL,
		[type]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[LotteryNumbersIndividual]
	ADD
	CONSTRAINT [DF_LotteryNumbersIndividual_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[LotteryNumbersIndividual] SET (LOCK_ESCALATION = TABLE)
GO
