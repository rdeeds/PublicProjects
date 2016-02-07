SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Scheduler] (
		[id]                  [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]          [smalldatetime] NOT NULL,
		[task]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[userphonenumber]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[scheduleddate]       [smalldatetime] NULL,
		[sent]                [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Scheduler]
	ADD
	CONSTRAINT [DF_Scheduler_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Scheduler]
	ADD
	CONSTRAINT [DF_Scheduler_sent]
	DEFAULT ((0)) FOR [sent]
GO
ALTER TABLE [Ryan].[Scheduler] SET (LOCK_ESCALATION = TABLE)
GO
