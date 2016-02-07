SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[ProtectedWOrds] (
		[id]                [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]        [smalldatetime] NOT NULL,
		[protectedword]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[adminonly]         [bit] NOT NULL,
		[whatsitdo]         [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[ProtectedWOrds]
	ADD
	CONSTRAINT [PK_ProtectedWOrds]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [Ryan].[ProtectedWOrds]
	ADD
	CONSTRAINT [DF_ProtectedWOrds_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[ProtectedWOrds] SET (LOCK_ESCALATION = TABLE)
GO
