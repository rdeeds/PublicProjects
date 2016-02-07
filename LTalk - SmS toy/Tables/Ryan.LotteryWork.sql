SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[LotteryWork] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[Type]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Drawdate]       [smalldatetime] NULL,
		[Numbers]        [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[multiplier]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[LotteryWork]
	ADD
	CONSTRAINT [DF_LotteryWork_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[LotteryWork] SET (LOCK_ESCALATION = TABLE)
GO
