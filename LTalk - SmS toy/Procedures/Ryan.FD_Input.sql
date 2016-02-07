SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Ryan].[FD_Input] @phonenumber nvarchar(100), @input nvarchar(100), @testing bit =false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	---------------User Creation 
	----------Trivia
declare @Tcount int,@TID int,@activebatchid nvarchar(100), @message nvarchar(max),@answer int, @a nvarchar(100), @b nvarchar(100), @c nvarchar(100), @d nvarchar(100)
declare @randomstring nvarchar(5)
declare @totalq decimal(18,2), @correctq decimal(18,2), @qper decimal(18,2), @qperint int


declare @callmedate smalldatetime
declare @jokeid int, @joke nvarchar(180) ---jokes	
declare  @overunderid int,  @overundercounter int  ---------Over Under game variables
declare @count int,  @name nvarchar(100), @type char, @subtype nvarchar(2), @check int,@currentstate nvarchar(100), @overunder int, @iteration int

	set @check=0

	set @count = (select count(*) from [PyLend].[Users] where [usernumber] = @phonenumber)

set @type=@input
if @type='+' or @type='-' or @type='.'
begin
set @input = (select replace(@input,@type,'') )
end



if @count = 0
begin
set @check=1
select 'Hello! Looks like you are new here. What should I call you? Please put a + infront of the name you would like me to use. type ? to find out what we can do together. ' as [output]
insert [PyLend].users([usernumber]) values (@phonenumber) 
end
if @count > 0
begin

set @name = (select username from [PyLend].[Users] where [usernumber] = @phonenumber)

if @type = '+'
begin
set @check=1
update [PyLend].[Users] set username = @input where usernumber=@phonenumber
select @input+', Cool your in there.' as [output]
end

if @type ='?' 
begin 
set @check=1
select 'Right now I am being created so what I can do is limited '+@name+ ', but keep checking back.
		1 Tell me a joke(warning may be dirty)
        2 Lets play a game
		3 Schedule a call
		4 play trivia

		you can change your name here any time by sending +NewName 
		' as [output]
return
end



update [PyLend].[Users] set lastused=getdate(), timesused=timesused+1 where usernumber = @phonenumber
	
end  ---------Every user goes through this - if nospecial characters we moveon.

----------------------END OF USER TESTING/CREATION
---------------------------

set @currentstate=(select currentstate from pylend.users where usernumber = @phonenumber)
if @currentstate is null set @currentstate='initial'



if @currentstate ='initial'
begin

if @input='1'
begin
set @check=1

set @jokeid =(SELECT TOP 1
      auto
   
  FROM [LTalk].[dbo].[Jokes]
  where length<120 
  order by newid()   )

  set @joke=(select joke from [LTalk].[dbo].[Jokes] where auto=@jokeid)

  select @joke as [output]
  return
end   -----End Joke

if @input=2
begin
set @check=0
update pylend.users set currentstate='OverUnder' where usernumber=@phonenumber
insert into ryan.overunder(usernumber) values(@phonenumber)
select @name +'You have started over under. You have 5 chances to pick a number between 1-100. I will tell you if the number I have picked is over or under the one you guess. to end game txt End. What is your first guess?' as [output]
return
end ----END overunder creation


if @input =3
begin

update pylend.users set currentstate='Callme' where usernumber=@phonenumber
select 'In how many minutes do you want me to call you?' as [output]
return
end 

if @input =4
begin


update pylend.users set currentstate='Trivia' where usernumber=@phonenumber
set @randomString = (select substring(replace(CONVERT(varchar(255), newid()),'-',''),0,50))
set @message='Welcome to trivia. You can end the game at anytime by entering tstop at anytime. Thanks for playing have fun


'

set @TID=(SELECT TOP 1 questionid from trivia2  where not questionid in(select questionid from triviahistory where usernumber=@phonenumber )order by newid())

set @message=@message+(select question from trivia2 where questionid =@tid)+'
'
set @answer=(select answernumb from trivia2 where questionid=@tid)


insert into triviahistory(usernumber,questionid,correctanswer,batchid,triviacount) 
values                    (@phonenumber, @tid,@answer,@randomstring,1)

---------Output question

set @a=(select Answera from trivia2 where questionid =@tid)
set @b=(select Answerb from trivia2 where questionid =@tid)
set @c=(select Answerc from trivia2 where questionid =@tid)
set @d=(select Answerd from trivia2 where questionid =@tid)

set @message=@message+'1 '+@a+' 2 '+@b+' 3 '+@c+' 4 '+@d












select @message as [output]
return
end 


end --end initial


if @currentstate='overunder'
begin


set @overunderid=(select id from [Ryan].[OverUnder] where [usernumber] = @phonenumber and active=1)
set @iteration = (select iteration from [Ryan].[OverUnder] where id=@overunderid)

if @iteration <=4
begin
set @overunder = (select gamenumber  from [Ryan].[OverUnder] where id=@overunderid)
update [Ryan].[OverUnder] set [iteration]=[iteration]+1 where id=@overunderid

set @overundercounter=5-(@iteration+1)

if @input > @overunder 
begin
select 'The number you selected was over the target. You have '+convert(nvarchar,@overundercounter) +'  chances left' as [output]

return 
end

if @input < @overunder
begin
 select 'The number you selected was under the target. You have '+convert(nvarchar,@overundercounter) +'  chances left' as [output]
 if @overundercounter > 0 return 
 end

 if @input = @overunder
 begin
 select 'You win!!!!' as [output] 
 update ryan.overunder set active =0 where id=@overunderid
update [LTalk].[PyLend].[Users] set currentstate ='initial' where usernumber=@phonenumber

 return
end

end

if @iteration =5 or @overundercounter =0
begin

select 'Im so sorry but you lose this time. Better luck next time.' as [output]
update ryan.overunder set active =0 where id=@overunderid
update [LTalk].[PyLend].[Users] set currentstate ='initial' where usernumber=@phonenumber

end

return
end

if @currentstate='Callme'
begin

set @callmedate =(dateadd(mi,convert(int,@input),getdate()))

insert into ryan.scheduler(scheduleddate,userphonenumber,task) values(@callmedate,@phonenumber,'Callme')
select 'You will be called at '+convert(nvarchar,@callmedate)+'PST!' as [output]
update [LTalk].[PyLend].[Users] set currentstate ='initial' where usernumber=@phonenumber

return
end --end call me


if @currentstate='trivia'
begin

set @tid =(select top 1 id from triviahistory where userinput is null)
set @randomstring =(select batchid from triviahistory where id=@tid)
if not @input='tstop'
begin 

set @answer=(select top 1 correctanswer from triviahistory where id=@tid)
update triviahistory set userinput=@input where id=@tid

set @tcount=(select triviacount from triviahistory where id=@tid)
if @answer=@input set @message='Correct! '
if not @answer = @input set @message='Incorrect! The correct answer is '+convert(nvarchar,@answer)+' '

set @TID=(SELECT TOP 1 questionid from trivia2  where not questionid in(select questionid from triviahistory where usernumber=@phonenumber )order by newid())

set @message=@message+' '+(select question from trivia2 where questionid =@tid)+'
'
set @answer=(select answernumb from trivia2 where questionid=@tid)

set @tcount=@tcount+1


insert into triviahistory(usernumber,questionid,correctanswer,batchid,triviacount) 
values                    (@phonenumber, @tid,@answer,@randomstring,@tcount)

---------Output question

set @a=(select Answera from trivia2 where questionid =@tid)
set @b=(select Answerb from trivia2 where questionid =@tid)
set @c=(select Answerc from trivia2 where questionid =@tid)
set @d=(select Answerd from trivia2 where questionid =@tid)

set @message=@message+'1 '+@a+' 2 '+@b+' 3 '+@c+' 4 '+@d

end---END stop
else 
begin

delete from triviahistory where id=@tid
update [LTalk].[PyLend].[users] set currentstate='initial'



set @totalq=(
SELECT     count(*)
FROM         Ryan.TriviaHistory
WHERE     (usernumber = @phonenumber) AND (batchid = @randomstring))

set @correctq=(SELECT     count(*)
FROM         Ryan.TriviaHistory
WHERE     (usernumber = @phonenumber) AND (batchid = @randomstring) and correct=1)

if @correctq >0 and @totalq>0
begin
set @qper=@correctq/@totalq
end
else 
begin

set @qper=0
end
--set @qperint=33

set @qperint=(select @qper*100)

set @message=(select 'You had '+convert(nvarchar,cast(@totalq as int))+' questions. You got '+convert(nvarchar,cast(@correctq as int))+' correct! Giving you at correct percentage of '+convert(nvarchar,@qperint)+'%')





end




select @message as [output]
return
end-----End trivia


if @check=0
begin
select 'Heya '+ @name+', we appreciate you visiting. Please type ? to see what we can do together. Thanks! Have a great day' as [output]
end  


END  --SP END

	/*







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




--select @input+', Cool your in there.' as [output]

end
set @name = (select username from [PyLend].[Users] where [usernumber] = @phonenumber)

if @type ='?' 
begin 
set @check=1
select 'Right now I am being created so what I can do is limited '+@name+ ', but keep checking back.
		1 Tell me a joke(warning may be dirty)
        2 Lets play a game

		you can change your name here any time by sending +NewName 
		' as [output]

end
declare @isgamestarted nvarchar(100)
declare @target int

if @subtype='2'
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

*/

GO
