SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Lotterypos] (
		[id]           [int] IDENTITY(1, 1) NOT NULL,
		[drawdate]     [smalldatetime] NULL,
		[type]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[numbers]      [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pos1]         [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pos2]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pos3]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pos4]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pos5]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Pos6]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Lotterypos] SET (LOCK_ESCALATION = TABLE)
GO
