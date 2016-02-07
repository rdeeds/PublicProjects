SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FDSP_Insert_Results] @userid int, @recipeid int, @sessionid nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 insert into [Ryan].[Recieved_recipies]([recipeid],[userid],[sessionid]) values(@recipeid,@userid,@sessionid)
    -- Insert statements for procedure here
	


END
GO
