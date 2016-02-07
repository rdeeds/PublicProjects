SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Choices] (
		[Id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[Choice]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Choices]
	ADD
	CONSTRAINT [DF_Choices_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Choices] SET (LOCK_ESCALATION = TABLE)
GO
