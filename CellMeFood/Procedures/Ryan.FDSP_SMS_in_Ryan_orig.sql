SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,> 
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [Ryan].[FDSP_SMS_in_Ryan_orig] @phonenumber nvarchar(100), @text nvarchar(200)

AS
BEGIN
------------------------------------------Variable Dec and init
declare @usercount int, @userid nvarchar
declare @string nvarchar(1000),  @useridnum int	
declare @out nvarchar(1000),@testchar char ,@param1 nvarchar(500)
declare @sqlfinal nvarchar(max),@sqlend nvarchar(1000),@sqlmiddle nvarchar(1000)
declare @pos int,@len int,@origlen int,@word nvarchar(100), @input nvarchar(100), @intcheck bit, @chartest char, @specialtest bit, @namesql nvarchar(1000), @namesql2 nvarchar(1000)
declare @plusq nvarchar(1000), @pluscount int,@ingrediantsql2 nvarchar(1000),@ingrediantsql1 nvarchar(1000), @plusqname nvarchar(1000), @plusqingrediant nvarchar(1000)
declare @minuscount int, @minusqname nvarchar(1000), @minusqingrediant nvarchar(1000), @plustotal nvarchar(max), @minustotal nvarchar(max), @questtest bit
declare @protectedwordtest int
declare @isadmin bit, @sessionid nvarchar(100)
set @questtest=0
--set @string = ' -yams +corn +chicken -mushroom'

set @specialtest=0 --Bit value to determine if a special character was found in the string
set @pluscount=0 --initialize value for iterating through all plusses
set @minuscount=0
set @plusq=' '
set @plusqname=' '
set @plusqingrediant=' '
set @minusqingrediant=' '
set @minusqname=' '

--------------------USER Creation/Mapping

		set @phonenumber=replace(@phonenumber,'+','')

		set @usercount = (select count(id) from users where usernumber=@phonenumber)

		set @isadmin=(select isadmin from users where usernumber=@phonenumber)

		if @usercount = 0
		begin
		 		 insert into users(usernumber) values(@phonenumber)
		 end
		 		
		set @useridnum = (select id from users where usernumber = @phonenumber)
		set @sessionid = (select right(CONVERT(varchar(255), NEWID())+convert(nvarchar,cast(rand()*10000000 as int)), 8))
	    
	set @userid=convert(nvarchar,@useridnum)

set @sqlend='order by newid()'


set @sqlfinal='SELECT TOP (5)  cellme.dbo.recipe.Name + ' +''''+' http://www.cellmefood.com/r/'+@userid+'/'+''''+'+'+'convert(nvarchar,cellme.dbo.recipe.id) +  '+'''  ----'+@sessionid+''''+'  as status1 
into #temp FROM   cellme.dbo.recipe INNER JOIN
             cellme.dbo.MainIngrediants ON cellme.dbo.recipe.id = cellme.dbo.MainIngrediants.recipeID
GROUP BY cellme.dbo.recipe.Name, cellme.dbo.recipe.Ingredients, cellme.dbo.recipe.Instructions, LEN(LTRIM(RTRIM(cellme.dbo.recipe.Instructions))), cellme.dbo.recipe.id, cellme.dbo.recipe.RecipeType
HAVING (COUNT(cellme.dbo.MainIngrediants.id) < 10) AND (NOT (cellme.dbo.recipe.RecipeType = N'+''''+'drinks'+''''+') AND NOT (cellme.dbo.recipe.RecipeType = N'+''''+'dip'+''''+') AND NOT (cellme.dbo.recipe.RecipeType = N'+''''+'dressing'+''''+'))
'


	
	-- -----------------DATA CLEAN UP
	SET NOCOUNT ON;
	insert into [Ryan].[Test](text,text2) values( @phonenumber, @text)
	set @text=rtrim(ltrim(@text))
	
	
	

	set @string=@text+' '


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
------------------------------------------------End Of Splitting string into elements

insert into [Ryan].[WhatWasSearchedFor]([userid],[wordused],sessionid) select @userid, element,  @sessionid from #temp ----------------Capturing who searched for what


set @protectedwordtest=(select distinct 1 from [Ryan].[ProtectedWOrds] where [protectedword] in (select element from #temp)) --Capturing if there was a protected word in list


set @origlen =(select max(id) from #temp)        ------------How many words were input       

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

--select @chartest as chartest
----------
if @chartest = '+' or @chartest ='-' or @chartest='?'    ----Test for special characters
begin

set @Specialtest=1

if @chartest ='+'                                 ------------------FOUND a plus on the front meaning add word to query
begin

set @pluscount=@pluscount+1
--select 'Inside No int loop Inside Plus for statment' as plus

Set @input=replace(@input,'+','')
set @input=@input

 if @pluscount = 1
 begin

 set @namesql=' AND (dbo.Recipe.Name LIKE N'+''''+'%'+''''+' + N'+''''+@input+' '''+' + N'+''''+'%'+''''--+') '
 set @ingrediantsql1 = ' or (dbo.Recipe.Ingredients LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''
 
 set @plusqname=@plusqname+@namesql
 set @plusqingrediant=@plusqingrediant+@ingrediantsql1


 end


 if @pluscount>1
 begin
 set @namesql2=' and dbo.Recipe.Name LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''
 set @ingrediantsql2 =' and dbo.Recipe.Ingredients LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''

 set @plusqname=@plusqname+@namesql2
 set @plusqingrediant=@plusqingrediant+@ingrediantsql2
   
 end

 end

if @chartest='-'                ---------------------------Found Minus on front---MINUS
begin
--select 'inside no int loop inside Minus for statment' as minus


set @minuscount=@minuscount+1


Set @input=replace(@input,'-','')
set @input=@input

 if @minuscount = 1
 begin
 set @namesql=' AND (dbo.Recipe.Name not LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''--+') '
 set @ingrediantsql1 = ' and (dbo.Recipe.Ingredients not LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''
 
 set @minusqname=@minusqname+@namesql
 set @minusqingrediant=@minusqingrediant+@ingrediantsql1
 end
 if @minuscount>1
 begin
 set @namesql2=' and dbo.Recipe.Name not LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''
 set @ingrediantsql2 =' and dbo.Recipe.Ingredients not LIKE N'+''''+'%'+''''+' + N'+''''+@input+''''+' + N'+''''+'%'+''''

 set @minusqname=@minusqname+@namesql2
 set @minusqingrediant=@minusqingrediant+@ingrediantsql2
   
			 end







end

if @chartest ='?'
begin

set @questtest =1

set @sqlfinal ='Goto http://www.cellmefood.com for info. 
Commands: 
+<word> +egg to see recipe with egg in it
-<word> -egg to see recipe without egg
? -Help


Words need a space between them but you can add as many items as you want.

Example: +egg -ham +pepper :That will get you all recipes that have those ingrediants

System Words: words you txt to get info
most - lists 5 most recipes you have viewed
last - lists the last 5 you have looked at

' 

if @isadmin=1 set @sqlfinal=@sqlfinal +' ADMIN: User - gets last 1 numbers that used it'

select @sqlfinal as status1

end



end  ------------end test special characters



if @specialtest=0
begin

if @protectedwordtest =1
begin

set @questtest=1


if @input='Most'
begin
SELECT TOP (5) dbo.Recipe.Name + ' ' + CONVERT(nvarchar, COUNT(Ryan.ViewedRecipies.id))  AS status1
FROM   dbo.Recipe INNER JOIN
             Ryan.ViewedRecipies ON dbo.Recipe.id = Ryan.ViewedRecipies.recipeid
WHERE (Ryan.ViewedRecipies.userid = @useridnum)
GROUP BY dbo.Recipe.Name
ORDER BY COUNT(Ryan.ViewedRecipies.id) DESC

end

if @input ='last'
begin

SELECT TOP (5) dbo.Recipe.Name as status1
FROM   dbo.Recipe INNER JOIN
             Ryan.ViewedRecipies ON dbo.Recipe.id = Ryan.ViewedRecipies.recipeid
WHERE (Ryan.ViewedRecipies.userid = @useridnum)
ORDER BY Ryan.ViewedRecipies.insertdate DESC
end


if @input ='user'
begin

if @isadmin=1
begin

SELECT TOP (10) text + ' ' + CONVERT(nvarchar, MAX(insertdate), 120) AS status1
FROM   Ryan.Test
GROUP BY text
ORDER BY MAX(insertdate) DESC


end
end




end



end
end --End string loop


set @origlen =(select max(id) from #temp)	---------new cool
end											------------End table iteration loop







if @pluscount >0
begin

set @plustotal =@plusqname+')'+@plusqingrediant+')'

set @sqlfinal=@sqlfinal+@plustotal

end

if @minuscount >0
begin

--select 'inside minus final' as minus

set @minustotal =@minusqname+')'+@minusqingrediant+')'

set @sqlfinal=@sqlfinal+@minustotal

end


set @sqlfinal=@sqlfinal+' order by newid(); declare @count int; set @count=(select count(*) from #temp); if @count = 0 select top 1 word as status1 from cellme.ryan.reasons order by newid()  else select * from #temp'

--select @sqlfinal as sqlfinal
--select @questtest as qtest

--select @sqlfinal as sqlfinal


if @questtest = 0 and @specialtest=1
begin


exec(@sqlfinal)
end


drop table #temp














/*


	if @text='vcard'
	begin

	select 'BEGIN:VCARD
VERSION:3.0
PRODID:-//Apple Inc.//iOS 8.1//EN
N:CellMeFood;"Bared";;;
FN:CellMeFood
EMAIL;type=INTERNET;type=WORK;type=pref:support@cellmefood.com
TEL;type=CELL;type=VOICE;type=pref:
item1.ADR;type=HOME;type=pref:;;
item2.URL;type=pref:www.CellMeFood.com
item2.X-ABLabel:_$!<HomePage>!$_
BDAY;value=date:1983-09-29
END:VCARD' as status1

set @intcheck =0

	end

	
	if @testchar='?' or @testchar='help' 
	begin

	select 
	'Welcome to CellMeFood - the easy fun way to find meals in a hurry. 
	The appless app is easy to use. Here is basic usage:
	
	1. If you want to see a recipe with a specific ingrediant use + 
	2. If you want to see a recipe that does not contain an ingrediant use -
	3. For help type help or ?
	4. Vcard will send you a vcard but it aint working 
	5. catagories will give you a list of the types of recipes we have

	example: You want a random recipe with eggs: +egg if you dont want egg: -egg

	once you see a recipe you like or are interested in text the id number and you will
	get the detailed ingrediants and instructions. 
	
	example -ID:1865 Name: Whole Wheat Waffles - You would text 1865

	Visit us on http://CellMeFood.com for more info - this is broker too at the moment. Tell ANTHONY to get busy!!!!! 
	
	' as status1 

	set @intcheck =0

	end


	if @testchar='+' 
	begin
	set @param1 =replace(@text,'+','')
	
	
	SELECT TOP (100) PERCENT dbo.Recipe.Name +' http://www.cellmefood.com/r/'+convert(nvarchar,@userid)+'/'+convert(nvarchar,dbo.Recipe.id)  as status1 
	into #temp
FROM   dbo.Recipe INNER JOIN
             dbo.MainIngrediants ON dbo.Recipe.id = dbo.MainIngrediants.recipeID
GROUP BY dbo.Recipe.Name, dbo.Recipe.Ingredients, dbo.Recipe.Instructions, LEN(LTRIM(RTRIM(dbo.Recipe.Instructions))), dbo.Recipe.id, dbo.Recipe.RecipeType
HAVING (COUNT(dbo.MainIngrediants.id) < 10) AND (NOT (dbo.Recipe.RecipeType = N'drinks') AND NOT (dbo.Recipe.RecipeType = N'dip') AND NOT (dbo.Recipe.RecipeType = N'dressing')) AND (dbo.Recipe.Name LIKE N'%' + @param1 + N'%') OR
             (dbo.Recipe.Ingredients LIKE N'%' + @param1 + N'%')
ORDER BY  LEN(LTRIM(RTRIM(dbo.Recipe.Instructions)))


select top 5 * from #temp order by newid()
drop table #temp
set @intcheck =0
end


if @testchar='-'
begin
set @param1 =replace(@text,'-','')

SELECT TOP (100) PERCENT dbo.Recipe.Name +' http://www.cellmefood.com/r/'+convert(nvarchar,@userid)+'/'+convert(nvarchar,dbo.Recipe.id)  as status1 
	into #temp1
FROM   dbo.Recipe INNER JOIN
             dbo.MainIngrediants ON dbo.Recipe.id = dbo.MainIngrediants.recipeID
WHERE (LEN(LTRIM(RTRIM(dbo.Recipe.Instructions))) < 250)
GROUP BY dbo.Recipe.Name, dbo.Recipe.Ingredients, dbo.Recipe.Instructions, dbo.Recipe.id, dbo.Recipe.RecipeType
HAVING (COUNT(dbo.MainIngrediants.id) < 10) AND (NOT (dbo.Recipe.RecipeType = N'drinks') AND NOT (dbo.Recipe.RecipeType = N'dip') AND NOT (dbo.Recipe.RecipeType = N'dressing')) AND (NOT (dbo.Recipe.Name = @param1)) AND (NOT (dbo.Recipe.Ingredients = @param1))
ORDER BY COUNT(dbo.MainIngrediants.id)

select top 5 * from #temp1 order by newid()
drop table #temp1

set @intcheck =0
end

--select @intcheck as intcheckdowntheroad

if @intcheck=1
begin
if @testchar between 1 and 10
begin

SELECT Ingredients+' '+char(13)+ Instructions as status1
FROM   dbo.Recipe
WHERE (id = @text)

/*
SELECT 'http://www.google.com/?q='+replace(name,' ','%20') as status1--+' '+char(13)+ Instructions
FROM   dbo.Recipe
WHERE (id = @text)
*/



end
end
	/*SELECT TOP (100) PERCENT convert(nvarchar,dbo.Recipe.id)+' '+ dbo.Recipe.RecipeType +' '+dbo.Recipe.Name+' '+convert(nvarchar, COUNT(dbo.MainIngrediants.id)) +' '+ dbo.Recipe.Ingredients +' '+ dbo.Recipe.Instructions as status1
into #temp
FROM   dbo.Recipe INNER JOIN
             dbo.MainIngrediants ON dbo.Recipe.id = dbo.MainIngrediants.recipeID
GROUP BY dbo.Recipe.Name, dbo.Recipe.Ingredients, dbo.Recipe.Instructions, LEN(LTRIM(RTRIM(dbo.Recipe.Instructions))), dbo.Recipe.id, dbo.Recipe.RecipeType
HAVING (LEN(LTRIM(RTRIM(dbo.Recipe.Instructions))) < 250) AND (COUNT(dbo.MainIngrediants.id) < 10) AND (NOT (dbo.Recipe.RecipeType = N'drinks') AND NOT (dbo.Recipe.RecipeType = N'dip') AND NOT (dbo.Recipe.RecipeType = N'dressing'))
*/








/*
	if @text='Cool' set @out = 'Dorothy you are so dang cool'
	if @text='Sweet' set @out ='Dorothy you are such a good big sister.'*/

    -- Insert statements for procedure here
	--select @out as status1

	--select 'Fuck you Zach!!!!!' as status1

	*/
END
GO
