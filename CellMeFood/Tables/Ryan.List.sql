SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[List] (
		[id]                  [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]          [smalldatetime] NOT NULL,
		[userid]              [int] NOT NULL,
		[recipeid]            [int] NOT NULL,
		[ingrediantid]        [int] NOT NULL,
		[ingrediantorder]     [int] NOT NULL,
		[added]               [bit] NOT NULL,
		[ingredient]          [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[List]
	ADD
	CONSTRAINT [DF_List_added]
	DEFAULT ((0)) FOR [added]
GO
ALTER TABLE [Ryan].[List]
	ADD
	CONSTRAINT [DF_List_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[List] SET (LOCK_ESCALATION = TABLE)
GO
