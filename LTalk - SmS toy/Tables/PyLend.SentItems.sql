SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [PyLend].[SentItems] (
		[id]                   [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]           [smalldatetime] NOT NULL,
		[usernumber]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[category]             [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[idofcategorysent]     [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [PyLend].[SentItems]
	ADD
	CONSTRAINT [DF_SentItems_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [PyLend].[SentItems] SET (LOCK_ESCALATION = TABLE)
GO
