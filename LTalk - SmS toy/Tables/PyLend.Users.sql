SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [PyLend].[Users] (
		[id]               [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]       [smalldatetime] NOT NULL,
		[usernumber]       [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[username]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[nickname]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CurrentState]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[lastused]         [smalldatetime] NULL,
		[timesused]        [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [PyLend].[Users]
	ADD
	CONSTRAINT [DF_Users_CurrentState]
	DEFAULT (N'initial') FOR [CurrentState]
GO
ALTER TABLE [PyLend].[Users]
	ADD
	CONSTRAINT [DF_Users_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [PyLend].[Users]
	ADD
	CONSTRAINT [DF_Users_timesused]
	DEFAULT ((1)) FOR [timesused]
GO
ALTER TABLE [PyLend].[Users]
	ADD
	CONSTRAINT [DF_Users_username]
	DEFAULT ('noname') FOR [username]
GO
ALTER TABLE [PyLend].[Users] SET (LOCK_ESCALATION = TABLE)
GO
