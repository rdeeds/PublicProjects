SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dimension] (
		[Language]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DimMeasurement]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DimText]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dimension] SET (LOCK_ESCALATION = TABLE)
GO
