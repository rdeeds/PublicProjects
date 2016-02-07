SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FDSP_Recipe_to_rate] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select top 1 [id] ,Name,replace(Ingredients,char(13),'<br>') as Ingredients,replace(Instructions, char(13),'<br>') as Instructions from cellme.[dbo].[Recipe] order by NEWID()
END
GO
