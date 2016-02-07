SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[bob]
	-- Add the parameters for the stored procedure here
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @string nvarchar(1000),  @useridnum int


declare @userid nvarchar(100)

set @useridnum=4
set @userid=convert(nvarchar,@useridnum)


/*
set @plusq='or (cellme.dbo.Recipe.Name LIKE N'+QUOTENAME('%', '''') +'+'+ QUOTENAME(replace(@input,'+',''), '''') +'+'+ 'N'+QUOTENAME('%', '''')+') and
             (cellme.dbo.Recipe.Ingredients LIKE N'+QUOTENAME('%', '''')+'+' + QUOTENAME(replace(@input,'+',''), '''')+ '+ N'+QUOTENAME('%', '''')+')'
			 select @plusq as plusq

			 /*
AND (dbo.Recipe.Name LIKE N'%' + @param1 + N'%') OR
             (dbo.Recipe.Ingredients LIKE N'%' + @param1 + N'%')


			 AND (dbo.Recipe.Name LIKE N'%'+'egg'+N'%') OR
             (dbo.Recipe.Ingredients LIKE N'%'+'egg'+ N'%')
*/


SELECT TOP (5)  dbo.Recipe.Name +' http://www.cellmefood.com/r/'+convert(nvarchar,@userid)+'/'+convert(nvarchar,dbo.Recipe.id)  as status1 
FROM   dbo.Recipe INNER JOIN
             dbo.MainIngrediants ON dbo.Recipe.id = dbo.MainIngrediants.recipeID
GROUP BY dbo.Recipe.Name, dbo.Recipe.Ingredients, dbo.Recipe.Instructions, LEN(LTRIM(RTRIM(dbo.Recipe.Instructions))), dbo.Recipe.id, dbo.Recipe.RecipeType
HAVING (COUNT(dbo.MainIngrediants.id) < 10) AND (NOT (dbo.Recipe.RecipeType = N'drinks') AND NOT (dbo.Recipe.RecipeType = N'dip') AND NOT (dbo.Recipe.RecipeType = N'dressing')) AND (dbo.Recipe.Name LIKE N'%' + @param1 + N'%') OR
             (dbo.Recipe.Ingredients LIKE N'%' + @param1 + N'%')
ORDER BY  newid()

AND (dbo.Recipe.Name LIKE N'%' + @param1 + N'%') OR
             (dbo.Recipe.Ingredients LIKE N'%' + @param1 + N'%')
			 
			 SELECT TOP (5)  dbo.Recipe.Name +www.cellmefood.com/r/+4)+'/'+convert(nvarchar,dbo.Recipe.id)  as status1 
FROM   dbo.Recipe INNER JOIN
             dbo.MainIngrediants ON dbo.Recipe.id = dbo.MainIngrediants.recipeID
GROUP BY dbo.Recipe.Name, dbo.Recipe.Ingredients, dbo.Recipe.Instructions, LEN(LTRIM(RTRIM(dbo.Recipe.Instructions))), dbo.Recipe.id, dbo.Recipe.RecipeType
HAVING (COUNT(dbo.MainIngrediants.id) < 10) AND (NOT (dbo.Recipe.RecipeType = N'drinks') AND NOT (dbo.Recipe.RecipeType = N'dip') AND NOT (dbo.Recipe.RecipeType = N'dressing'))AND (dbo.Recipe.Name LIKE N'%'+'egg'+N'%') OR
             (dbo.Recipe.Ingredients LIKE N'%'+'egg'+ N'%')

			 +' http://www.cellmefood.com/r/'+convert(nvarchar,@userid)+'/'+convert(nvarchar,dbo.Recipe.id)  as status1 
*/

declare @sqlfinal nvarchar(max),@sqlend nvarchar(1000),@sqlmiddle nvarchar(1000)
set @sqlend='order by newid()'

set @sqlfinal='SELECT TOP (5)  cellme.dbo.recipe.Name + ' +''''+' http://www.cellmefood.com/r/'+@userid+'/'+''''+'+'+'convert(nvarchar,cellme.dbo.recipe.id)  as status1 
FROM   cellme.dbo.recipe INNER JOIN
             cellme.dbo.MainIngrediants ON cellme.dbo.recipe.id = cellme.dbo.MainIngrediants.recipeID
GROUP BY cellme.dbo.recipe.Name, cellme.dbo.recipe.Ingredients, cellme.dbo.recipe.Instructions, LEN(LTRIM(RTRIM(cellme.dbo.recipe.Instructions))), cellme.dbo.recipe.id, cellme.dbo.recipe.RecipeType
HAVING (COUNT(cellme.dbo.MainIngrediants.id) < 10) AND (NOT (cellme.dbo.recipe.RecipeType = N'+''''+'drinks'+''''+') AND NOT (cellme.dbo.recipe.RecipeType = N'+''''+'dip'+''''+') AND NOT (cellme.dbo.recipe.RecipeType = N'+''''+'dressing'+''''+'))
'


declare @pos int,@len int,@origlen int,@word nvarchar(100), @input nvarchar(100), @intcheck bit, @chartest char, @specialtest bit, @namesql nvarchar(1000), @namesql2 nvarchar(1000)
declare @plusq nvarchar(1000), @pluscount int

set @string = '+egg +bacon'
set @string=@string+ ' '
set @specialtest=0 --Bit value to determine if a special character was found in the string
set @pluscount=0 --initialize value for iterating through all plusses
set @plusq=' '


create table #temp(id int identity(1,1), element nvarchar(100)) ---------Table to hold input from user

set @origlen=len(@string) --Leangth of string input from user

while @origlen>=1          ------------Starting loop breaking string into individual elements
begin

set @pos=charindex(' ',@string) --position of next blank
set @word=(select substring(@string,0,@pos))--characters between 0 and the blank

set @string=ltrim(replace(@string, @word,'')) --Remove characters
set @origlen=len(@string) --new leangth

insert into #temp(element) values(@word)
end

set @origlen =(select max(id) from #temp)               

while @origlen > 0                                  ---------------iterate through input loop
begin

set @input =(select top 1 element from #temp)
delete from #temp where element=@input

set @intcheck =isnumeric(@input)

if @intcheck =1
begin
 select 'Int'
end

if @intcheck=0     -------------------It is not a number -- Enter major loop
begin

set @chartest =@input

----------
if @chartest = '+' or @chartest ='-' or @chartest='?'    ----Test for special characters
begin

set @Specialtest=1

if @chartest ='+'                                 ------------------FOUND a plus on the front meaning add word to query
begin
set @pluscount=@pluscount+1
select 'Inside No int loop Inside Plus for statment' as plus

Set @input=replace(@input,'+','')


 if @pluscount = 1
 begin
 set @namesql=' AND (dbo.Recipe.Name LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''--+') '

 set @plusq=@plusq+@namesql

 end
 if @pluscount>1
 begin
 set @namesql2=' or dbo.Recipe.Name LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''

 set @plusQ=@plusQ+@namesql2
   
			 end

if @chartest='-'
begin
select 'inside no int loop inside Minus for statment' as minus
end

if @chartest ='?'
begin
select 'inside no int loop inside help' as question
end



end  ------------end test special characters

set @plusq=@plusq+')'

if @specialtest=0
begin

select 'Its a word '+@input as nointword


end
end --End string loop


set @origlen =(select max(id) from #temp) ---------new cool
end      ------------End table iteration loop

--select * from #temp

set @sqlfinal=@sqlfinal+@sqlend
select @sqlfinal as final

exec(@sqlfinal)

drop table #temp

END

end
GO
