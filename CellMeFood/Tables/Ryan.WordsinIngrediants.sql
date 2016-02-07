SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[WordsinIngrediants] (
		[id]             [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]     [smalldatetime] NOT NULL,
		[recipeid]       [int] NOT NULL,
		[word]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[WordsinIngrediants]
	ADD
	CONSTRAINT [DF_WordsinIngrediants_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
CREATE NONCLUSTERED INDEX [idx_DCh_2845_2844_WordsinIngrediants]
	ON [Ryan].[WordsinIngrediants] ([recipeid])
	INCLUDE ([id], [word])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'getdate()', 'SCHEMA', N'Ryan', 'TABLE', N'WordsinIngrediants', 'COLUMN', N'insertdate'
GO
ALTER TABLE [Ryan].[WordsinIngrediants] SET (LOCK_ESCALATION = TABLE)
GO
