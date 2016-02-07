SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE LotteryParser
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select id,drawdate, type, numbers,substring(numbers,0,3) as Pos1,substring(numbers,4,2) as Pos2,substring(numbers,7,2) as Pos3,substring(numbers,10,2) as Pos4,substring(numbers,13,2) as Pos5,substring(numbers,16,2) as Pos6 
  from lotterywork
END
GO
