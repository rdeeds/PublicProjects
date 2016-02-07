SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Ryan].[Character] (
		[id]                  [int] IDENTITY(1, 1) NOT NULL,
		[insertdate]          [smalldatetime] NOT NULL,
		[name]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[lvl]                 [int] NOT NULL,
		[hp]                  [int] NOT NULL,
		[damage]              [int] NOT NULL,
		[weapon]              [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[userphonenumber]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Ryan].[Character]
	ADD
	CONSTRAINT [DF_Character_damage]
	DEFAULT ((1)) FOR [damage]
GO
ALTER TABLE [Ryan].[Character]
	ADD
	CONSTRAINT [DF_Character_hp]
	DEFAULT ((10)) FOR [hp]
GO
ALTER TABLE [Ryan].[Character]
	ADD
	CONSTRAINT [DF_Character_insertdate]
	DEFAULT (getdate()) FOR [insertdate]
GO
ALTER TABLE [Ryan].[Character]
	ADD
	CONSTRAINT [DF_Character_lvl]
	DEFAULT ((0)) FOR [lvl]
GO
ALTER TABLE [Ryan].[Character]
	ADD
	CONSTRAINT [DF_Character_name]
	DEFAULT (N'Harmon') FOR [name]
GO
ALTER TABLE [Ryan].[Character]
	ADD
	CONSTRAINT [DF_Character_weapon]
	DEFAULT (N'fist') FOR [weapon]
GO
ALTER TABLE [Ryan].[Character] SET (LOCK_ESCALATION = TABLE)
GO
