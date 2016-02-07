SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[WhatWasSearchedFor] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[userid]         [int] NOT NULL,
		[wordused]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[sessionid]      [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[WhatWasSearchedFor]
	ADD
	CONSTRAINT [DF_WhatWasSearchedFor_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[WhatWasSearchedFor] SET (LOCK_ESCALATION = TABLE)
GO
