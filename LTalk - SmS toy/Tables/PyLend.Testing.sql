SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [PyLend].[Testing] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[Phone]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Text]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [PyLend].[Testing]
	ADD
	CONSTRAINT [DF_Testing_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [PyLend].[Testing] SET (LOCK_ESCALATION = TABLE)
GO
