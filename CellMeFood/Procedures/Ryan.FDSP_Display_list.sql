SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FDSP_Display_list] @userid int=2
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
/*	SELECT TOP (100) PERCENT Ryan.List.userid, Ryan.List.recipeid, Ryan.List.id as listid, Ryan.List.added, dbo.MainIngrediants.ingrediant as ingredient, Ryan.List.id
FROM   Ryan.List INNER JOIN
             dbo.MainIngrediants ON Ryan.List.ingrediantid = dbo.MainIngrediants.id
WHERE (Ryan.List.userid = @userid) and added=0
ORDER BY Ryan.List.ingrediantorder, Ryan.List.id*/

SELECT TOP (100) PERCENT userid, recipeid, id AS listid, added, ingredient, id
FROM   Ryan.List
WHERE (userid = @userid) AND (added = 0) AND (NOT (ingredient = 'add'))
ORDER BY ingrediantorder, listid

end
GO
