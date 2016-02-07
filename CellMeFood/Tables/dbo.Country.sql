SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country] (
		[ID]          [int] NOT NULL,
		[Country]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[frmUser]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Country] SET (LOCK_ESCALATION = TABLE)
GO
