SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FDSP_Create_list] @userid int, @recipeid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--declare @userid int=2

	declare @test int

	set @test=0

	set @test=(select count(id) from list where [recipeid] = @recipeid and userid=@userid )

	if @test=0
	begin

insert into [Ryan].[List]([userid],[recipeid],[ingrediantid],[ingrediantorder],[ingredient]) 
select @userid, [recipeID],[id],[Orderofingrediant], ingrediant from[MainIngrediants] where recipeid =@recipeid

end

END
GO
