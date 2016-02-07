SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Test] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[text]           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[text2]          [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Test]
	ADD
	CONSTRAINT [DF_Test_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Test] SET (LOCK_ESCALATION = TABLE)
GO
