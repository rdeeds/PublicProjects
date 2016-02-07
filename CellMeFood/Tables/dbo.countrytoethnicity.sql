SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[countrytoethnicity] (
		[Ethnicity]     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Country]       [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[countrytoethnicity] SET (LOCK_ESCALATION = TABLE)
GO
