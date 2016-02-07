SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE FDSP_Parser
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @string nvarchar(1000), @pos int, @origlen int, @count int, @numbrecord int,@lentest int, @currentid int,@word nvarchar(200)


create table #temp(id int identity(1,1), recipeid int, ingrediants nvarchar(1000))


insert into #temp(recipeid, ingrediants)
select top 500 id, ingredients from cellme.dbo.recipe  where id not in (select distinct [recipeid] from [Ryan].[WordsinIngrediants])
order by id
set @numbrecord=(select count(id) from #temp)

set @count=0

while @numbrecord >= @count
begin


set @currentid =(select top 1 recipeid from #temp) 
set @string=(select top 1 ltrim(rtrim(replace(replace(ingrediants,char(13),''),char(9),'')))+' ' from  #temp)
delete from #temp where recipeid=@currentid 

set @origlen=len(@string) --Leangth of string input from user
set @lentest=0

while @origlen>3          ------------Starting loop breaking string into individual elements
begin

set @pos=charindex(' ',@string) --position of next blank
set @word=(select substring(@string,0,@pos))--characters between 0 and the blank

set @string=ltrim(replace(@string, @word,'')) --Remove characters

set @lentest=( select 1 WHERE @string NOT LIKE '%[a-z0-9]%')

if @lentest is null
begin

set @origlen=len(@string) --new leangth
--select @word as word, @origlen as wordlen
insert into [Ryan].[WordsinIngrediants](recipeid, word) values(@currentid,@word)
end
else set @origlen=0

end

set @count=@count+1



end





drop table #temp
END
GO
