SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clean3] (
		[id]                    [int] IDENTITY(1, 1) NOT NULL,
		[recipeid]              [int] NOT NULL,
		[orderofingrediant]     [int] NOT NULL,
		[ingrediant]            [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[clean3] SET (LOCK_ESCALATION = TABLE)
GO
