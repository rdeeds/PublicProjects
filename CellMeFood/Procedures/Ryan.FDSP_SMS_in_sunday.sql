SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,> 
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FDSP_SMS_in_sunday] 
(
	@phonenumber nvarchar(100)
,	@text nvarchar(200)
)
AS
BEGIN
------------------------------------------Variable Dec and init
declare @usercount int, @userid nvarchar
declare @string nvarchar(1000),  @useridnum int	
declare @out nvarchar(1000),@testchar char ,@param1 nvarchar(500)
declare @sqlfinal nvarchar(max),@sqlend nvarchar(1000),@sqlmiddle nvarchar(1000)
declare @pos int,@len int,@origlen int,@word nvarchar(100), @input nvarchar(100), @intcheck bit, @chartest char, @specialchar bit, @namesql nvarchar(1000), @namesql2 nvarchar(1000)
declare @plusq nvarchar(1000), @pluscount int,@ingrediantsql2 nvarchar(1000),@ingrediantsql1 nvarchar(1000), @plusqname nvarchar(1000), @plusqingrediant nvarchar(1000)
declare @minuscount int, @minusqname nvarchar(1000), @minusqingrediant nvarchar(1000), @plustotal nvarchar(max), @minustotal nvarchar(max), @questtest bit
declare @protectedwordfound int
declare @isadmin bit, @sessionid nvarchar(100)
set @questtest=0
--set @string = ' -yams +corn +chicken -mushroom'
declare @countries Type_CountryListTable	-- DP: countries temp table

set @specialchar=0 --Bit value to determine if a special character was found in the string
set @pluscount=0 --initialize value for iterating through all plusses
set @minuscount=0
set @plusq=' '
set @plusqname=' '
set @plusqingrediant=' '
set @minusqingrediant=' '
set @minusqname=' '
--set @countries=''''''

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


-- TODO: DP: put excluded recipie types to separate table and do an outer join
set @sqlfinal = N'SELECT  
	r.Name + ' +''''+' http://www.cellmefood.com/r/'+@userid+'/'+''''+'+'+'convert(nvarchar,r.id) +  '+'''  ----'+@sessionid+''''+'  as status1 
	into dbo.#temp 
FROM   cellme.dbo.recipe r
INNER JOIN   cellme.dbo.MainIngrediants i ON i.recipeID = r.id
{countries}
WHERE r.RecipeType not in (N''drinks'', N''dip'', N''dressing'')
GROUP BY r.id, r.Name, r.Ingredients /*, r.Instructions, LEN(LTRIM(RTRIM(r.Instructions))), r.id, r.RecipeType*/
HAVING 1=1 /*COUNT(i.id) < 10*/
'


	
-- -----------------DATA CLEAN UP
SET NOCOUNT ON;
insert into [Ryan].[Test](text,text2) values( @phonenumber, @text)
set @text=rtrim(ltrim(@text))
	
	
	

set @string=@text+' '


declare @words table (id int identity(1,1), element nvarchar(100)) ---------Table to hold input from user

set @origlen=len(@string) --Leangth of string input from user

while @origlen>=1          ------------Starting loop breaking string into individual elements
begin

	set @pos=charindex(' ',@string) --position of next blank
	set @word=(select substring(@string,0,@pos))--characters between 0 and the blank

	set @string=ltrim(replace(@string, @word,'')) --Remove characters
	set @origlen=len(@string) --new leangth

	insert into @words(element) values(@word)
end
------------------------------------------------End Of Splitting string into elements


insert into [Ryan].[WhatWasSearchedFor]([userid],[wordused],sessionid) select @userid, element,  @sessionid from @words ----------------Capturing who searched for what


set @protectedwordfound=(select distinct 1 from [Ryan].[ProtectedWOrds] where [protectedword] in (select element from @words)) --Capturing if there was a protected word in list


set @origlen =(select max(id) from @words)        ------------How many words were input       

while @origlen > 0                                  ---------------iterate through input loop
begin

	set @input =(select top 1 element from @words)
	delete from @words where element=@input

	set @intcheck =isnumeric(@input)

	if @intcheck =1
		select 'Int'

	if @intcheck = 0     -------------------It is not a number -- Enter major loop
	begin

		set @chartest = @input

		--select @chartest as chartest
		----------
		if @chartest = '+' or @chartest = '-' or @chartest = '?'    ----Test for special characters
		begin

			set @specialchar = 1

			if @chartest = '+'                ------------------FOUND a plus on the front meaning add word to query
			begin

				set @pluscount = @pluscount + 1
				--select 'Inside No int loop Inside Plus for statment' as plus

				Set @input=replace(@input,'+','')
				set @input=@input

				if @pluscount = 1
				begin
					set @namesql =' AND ((r.Name LIKE N''%'+@input+'%'''
					set @ingrediantsql1 = ' or (r.Ingredients LIKE N''%'+@input+'%'''
				end


				if @pluscount>1
				begin
					set @namesql=' and r.Name LIKE N''%'+@input+'%'''
					set @ingrediantsql1 =' and r.Ingredients LIKE N''%'+@input+'%'''
				end

				set @plusqname = @plusqname + @namesql
				set @plusqingrediant = @plusqingrediant + @ingrediantsql1

			end		-- @chartest ='+'

			if @chartest = '-'                ---------------------------Found Minus on front---MINUS
			begin
				--select 'inside no int loop inside Minus for statment' as minus


				set @minuscount = @minuscount+1


				Set @input=replace(@input,'-','')
				set @input=@input

				if @minuscount = 1
				begin
					set @namesql=' AND (r.Name not LIKE N''%'+@input+'%'''
					set @ingrediantsql1 = ' and (r.Ingredients not LIKE N''%'+@input+'%'''
				end
				if @minuscount > 1
				begin
					set @namesql=' and r.Name not LIKE N''%'+@input+'%'''
					set @ingrediantsql1 =' and r.Ingredients not LIKE N''%'+@input+'%'''
				end

				set @minusqname = @minusqname + @namesql
				set @minusqingrediant = @minusqingrediant + @ingrediantsql1

			end		-- @chartest='-'

			if @chartest = '?'
			begin

				set @questtest =1

				set @sqlfinal ='Goto http://www.cellmefood.com for info. 
Commands: 
+<word> +egg [<category>] to see recipe with egg in it
-<word> -egg [<category>] to see recipe without egg
? -Help

Words need a space between them but you can add as many items as you want.

Example: +egg -ham +pepper :That will get you all recipes that have those ingrediants

System Words: words you txt to get info
most - lists 5 most recipes you have viewed
last - lists the last 5 you have looked at
cats - lists all categories

' 

				if @isadmin = 1 
					set @sqlfinal = @sqlfinal +' ADMIN: User - gets last 1 numbers that used it'

				--select @sqlfinal as status1

			end		-- @chartest = '?'

		end  ------------end test special characters

		else --if @specialchar = 0
		begin

			if @protectedwordfound = 1
			begin

				set @questtest = 1

				if @input = 'most'
				begin
					SELECT TOP (5) dbo.Recipe.Name + ' ' + CONVERT(nvarchar, COUNT(Ryan.ViewedRecipies.id))  AS status1
					FROM   dbo.Recipe INNER JOIN
								 Ryan.ViewedRecipies ON dbo.Recipe.id = Ryan.ViewedRecipies.recipeid
					WHERE (Ryan.ViewedRecipies.userid = @useridnum)
					GROUP BY dbo.Recipe.Name
					ORDER BY COUNT(Ryan.ViewedRecipies.id) DESC
					;
					return;
				end

				if @input ='last'
				begin
					SELECT TOP (5) dbo.Recipe.Name as status1
					FROM   dbo.Recipe INNER JOIN
								 Ryan.ViewedRecipies ON dbo.Recipe.id = Ryan.ViewedRecipies.recipeid
					WHERE (Ryan.ViewedRecipies.userid = @useridnum)
					ORDER BY Ryan.ViewedRecipies.insertdate DESC
					;
					return 0;
				end

				if @input ='add'
				begin
					insert into list(userid,recipeid,ingrediantid,ingrediantorder,ingredient) select @userid,0,0,0,replace(replace(element,'+',''),'-','') from @words
					;
					return 0;
				end

				if @input = 'user'
				begin
					if @isadmin=1
					begin
						SELECT TOP (10) text + ' ' + CONVERT(nvarchar, MAX(insertdate), 120) AS status1
						FROM   Ryan.Test
						GROUP BY text
						ORDER BY MAX(insertdate) DESC
						;
						return 0;
					end
				end

				-- DP: categories with recipie counts
				if @input = 'cats'
				begin
					with _r as (
						select ethnicity, r.Id
						from [countrytoethnicity] e 
							inner join [recipe] r on r.RecipeCountry=e.Country
							INNER JOIN   [MainIngrediants] i ON i.recipeID = r.id
						WHERE r.RecipeType not in (N'drinks', N'dip', N'dressing')
					)
					SELECT status1 = ethnicity + N' (' + convert(nvarchar(100),count(distinct id)) + N')'
						from _r
						group by ethnicity
						ORDER BY 1
					;
					return 0;
				end

			end		-- @protectedwordfound = 1

			else begin

				-- DP: search countries based on ethnicity
				insert @countries 
					select left(Country, 50) from dbo.[countrytoethnicity] where Ethnicity = @input
				;

			end

		end			-- @specialchar = 0

	end --End string loop

	set @origlen =(select max(id) from @words)	---------new cool

end											------------End table iteration loop


if @pluscount > 0
begin

	set @plustotal = @plusqname + ')' + @plusqingrediant + '))'

	set @sqlfinal = @sqlfinal + @plustotal

end

if @minuscount > 0
begin

	--select 'inside minus final' as minus

	set @minustotal = @minusqname + ')' + @minusqingrediant + ')'

	set @sqlfinal = @sqlfinal + @minustotal

end


set @sqlfinal=@sqlfinal+'; if not exists(select 1 from #temp) select top 1 word as status1 from [reasons] order by newid()  else select top 5 status1 from #temp order by newid();'

--if @questtest = 0 and @specialchar=1
--begin

	set @sqlfinal = replace(@sqlfinal, N'{countries}', case when exists(select 1 from @countries) 
		then N'inner join @countries c on c.Name = r.[RecipeCountry]'
		else N'/* all countries */' end
		);

	--select @sqlfinal as sqlfinal

	--exec(@sqlfinal)
	exec sp_executesql @sqlfinal, N'@countries Type_CountryListTable readonly', @countries
--end









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
