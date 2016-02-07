SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ingredients] (
		[Ingredient]          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Calorific Value]     [int] NULL,
		[ValueDimVal]         [float] NULL,
		[ValueDim]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ingredients] SET (LOCK_ESCALATION = TABLE)
GO
