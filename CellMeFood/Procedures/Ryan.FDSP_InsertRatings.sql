SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FDSP_InsertRatings] @recipeid int, @easy int, @ethnic int, @like int, @time int, @categories nvarchar(100), @note nvarchar(1000) =null, @credit nvarchar(100) =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;




    -- Insert statements for procedure here
	insert into [Ryan].[Ratings](recipeid,[Easyid],[ethnic],[likeid],[timeid],[note],[Credit]) values (@recipeid,@easy,@ethnic,@like,@time,@note,@credit)


	declare @origlen int, @string nvarchar(1000), @word nvarchar(1000), @pos int


set @string=@categories+','

create table #temp(id int identity(1,1), element nvarchar(100)) ---------Table to hold input from user

set @origlen=len(@string) --Leangth of string input from user

while @origlen>1          ------------Starting loop breaking string into individual elements
begin

set @pos=charindex(',',@string) --position of next blank
set @word=(select substring(@string,0,@pos+1))--characters between 0 and the blank
set @string=ltrim(replace(@string, @word,'')) --Remove characters
set @origlen=len(@string) --new leangth

insert into #temp(element) values(replace(@word,',',''))
end

insert into [Ryan].[AssignedCategories](catid,recipeid) select element, @recipeid as recipeid from #temp

drop table #temp

--FDSP_InsertRatings @recipeid int, @easy int, @ethnic int, @like int, @time int, @categories nvarchar(100), @note nvarchar(1000), @credit nvarchar(100)


--Fdsp_insertRatings 1,1,1,1,1,'1,2,3,4,5,6,7,8,9'
	


END
GO
