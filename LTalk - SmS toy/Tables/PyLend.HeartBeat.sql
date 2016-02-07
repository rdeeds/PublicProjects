SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [PyLend].[HeartBeat] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[heartbeat]      [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [PyLend].[HeartBeat]
	ADD
	CONSTRAINT [DF_HeartBeat_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [PyLend].[HeartBeat] SET (LOCK_ESCALATION = TABLE)
GO
