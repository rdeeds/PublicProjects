SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[OverUnder] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[usernumber]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[gamenumber]     [int] NULL,
		[iteration]      [int] NULL,
		[active]         [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[OverUnder]
	ADD
	CONSTRAINT [DF_OverUnder_active]
	DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [Ryan].[OverUnder]
	ADD
	CONSTRAINT [DF_OverUnder_gamenumber]
	DEFAULT (CONVERT([int],rand()*(100))) FOR [gamenumber]
GO
ALTER TABLE [Ryan].[OverUnder]
	ADD
	CONSTRAINT [DF_OverUnder_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[OverUnder]
	ADD
	CONSTRAINT [DF_OverUnder_iteration]
	DEFAULT ((0)) FOR [iteration]
GO
ALTER TABLE [Ryan].[OverUnder] SET (LOCK_ESCALATION = TABLE)
GO
