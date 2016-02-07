SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE FDSP_Update_checklist @userid int, @listid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


declare @currentstatus bit,@newstatus bit

set @currentstatus =(select [added] from [Ryan].[List] where id=@listid and userid=@userid)

if @currentstatus=1 set @newstatus = 0 else set @newstatus=1

update ryan.list set [added] = @newstatus where ryan.list.id=@listid


SELECT  [id]
      ,[insertdate]
      ,[userid]
      ,[recipeid]
      ,[ingrediantid]
      ,[ingrediantorder]
      ,[added]
  FROM [cellme].[Ryan].[List] where userid=@userid order by id

END
GO
