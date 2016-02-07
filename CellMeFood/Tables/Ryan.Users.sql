SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Users] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[usernumber]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[isadmin]        [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Users]
	ADD
	CONSTRAINT [DF_Users_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Users]
	ADD
	CONSTRAINT [DF_Users_isadmin]
	DEFAULT ((0)) FOR [isadmin]
GO
ALTER TABLE [Ryan].[Users] SET (LOCK_ESCALATION = TABLE)
GO
