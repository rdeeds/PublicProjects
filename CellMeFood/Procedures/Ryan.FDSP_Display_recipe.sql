SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FDSP_Display_recipe] @id int, @userid int
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into [Ryan].[ViewedRecipies](recipeid,userid) values(@id,@userid)

    -- Insert statements for procedure here
	SELECT     Name,replace(Ingredients,char(13),'<br>') as ingredients, replace(Instructions, char(13),'<br>') as Instructions
FROM         dbo.Recipe
WHERE     (id = @id)


END
GO
