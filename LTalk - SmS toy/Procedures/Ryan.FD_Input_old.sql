SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [Ryan].[FD_Input_old] @phonenumber nvarchar(100), @input nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update [PyLend].[Users] set lastused=getdate(), timesused=timesused+1 where usernumber = @phonenumber
	
    -- Insert statements for procedure here
	insert [PyLend].[Testing]([Phone],[Text]) values (@phonenumber, @input) 
	
	
declare  @overunderid int,  @overundercounter int  ---------Over Under game variables
declare @count int,  @name nvarchar(100), @type char, @subtype nvarchar(2), @check int,@currentstate nvarchar(100), @overunder int, @iteration int


set @currentstate=(select currentstate from pylend.users where usernumber = @phonenumber)
if @currentstate is null set @currentstate='initial'

if @currentstate='overunder'
begin

set @overunderid=(select id from [Ryan].[OverUnder] where [usernumber] = @phonenumber and active=1)
set @iteration = (select iteration from [Ryan].[OverUnder] where id=@overunderid)

if @iteration <=5
begin
set @overunder = (select id from [Ryan].[OverUnder] where [usernumber] = @phonenumber and active=1)
update [Ryan].[OverUnder] set [iteration]=[iteration]+1 where [usernumber] = @phonenumber and active=1

set @overundercounter=5-@iteration

if @input > @overunder 
begin
select 'The number you selected was over the target. You have '+convert(nvarchar,@iteration) +' many chances left' as [output]

return 
end

if @input < @overunder
begin
 select 'The number you selected was under the target. You have '+convert(nvarchar,@iteration) +' many chances left' as [output]
 return 

 end

 if @input = @overunder
 begin

 select 'You win!!!!' as [output] 

 return

end
end
else
begin

select 'Im so sorry but you lose this time. Better luck next time.' as [output]
update ryan.overunder set active =0 where id=@overunderid
update pyland.users set currentstate ='initial' where usernumber=@phonenumber

end

return
end
end

set @check=0
set @type = @input 

if @type='+' or @type='-' or @type='.'
begin
set @input = (select replace(@input,@type,'') )
end

if @type='/'
begin

set @subtype=@input

end

--select @subtype as sub

set @count = (select count(*) from [PyLend].[Users] where [usernumber] = @phonenumber)

if @count = 0
begin
set @check=1
select 'Hello! Looks like you are new here. What should I call you? Please put a + infront of the name you would like me to use. type ? to find out what we can do together. ' as [output]
insert [PyLend].users([usernumber]) values (@phonenumber) 
end
if @count > 0
begin

if @type = '+'
begin
set @check=1
update [PyLend].[Users] set username = @input where usernumber=@phonenumber
select @input+', Cool your in there.' as [output]

end



--select @input+', Cool your in there.' as [output]

end
set @name = (select username from [PyLend].[Users] where [usernumber] = @phonenumber)

if @type ='?' 
begin 
set @check=1
select 'Right now I am being created so what I can do is limited '+@name+ ', but keep checking back.
		/1 Tell me a joke(warning may be dirty)
        /2 Lets play a game

		you can change your name here any time by sending +NewName 
		' as [output]

end
declare @isgamestarted nvarchar(100)
declare @target int

if @subtype='/2'
begin
set @check=1
select 'inside' as inside
set @isgamestarted=(select currentstate from pylend.users where usernumber=@phonenumber)

if not @isgamestarted='overunder'
begin
update pylend.users set currentstate='OverUnder' where usernumber=@phonenumber
insert into ryan.overunder(usernumber) values(@phonenumber)
select @name +'You have started over under. You have 5 chances to pick a number between 1-100. I will tell you if the number I have picked is over or under the one you guess. to end game txt End. What is your first guess?' as [output]
end
else
begin

set @target=(select gamenumber from overunder where usernumber=@phonenumber and active=1)

end


end
else select 'you are already playing a game silly, i am waiting for your guess' as [output]


declare @jokeid int, @joke nvarchar(180)

if @subtype='/1'
begin
set @check=1

set @jokeid =(SELECT TOP 1
      auto
   
  FROM [LTalk].[dbo].[Jokes]
  where length<120 
  order by newid()   )

  set @joke=(select joke from [LTalk].[dbo].[Jokes] where auto=@jokeid)

  select @joke as [output]

end

if @check=0
begin
select 'Heya '+ @name+', we appreciate you visiting. Please type ? to see what we can do together. Thanks! Have a great day' as [output]

end

	--select 'Got It' as [output]



GO
