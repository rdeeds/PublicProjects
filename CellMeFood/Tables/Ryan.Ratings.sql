SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Ratings] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[recipeid]       [int] NULL,
		[Easyid]         [int] NOT NULL,
		[ethnic]         [int] NOT NULL,
		[likeid]         [int] NULL,
		[timeid]         [int] NULL,
		[note]           [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Credit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Ratings]
	ADD
	CONSTRAINT [DF_Ratings_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Ratings] SET (LOCK_ESCALATION = TABLE)
GO
