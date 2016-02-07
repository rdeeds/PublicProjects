SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =================================
CREATE PROCEDURE [Ryan].[FD_Timer] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
declare @scheduleid int, @schedulecount int
declare @message nvarchar(100)
	
	declare @id int, @phonenumber nvarchar(100), @joke nvarchar(150)
	declare @interval int, @tosend int 
	set @interval = 0
	set @tosend=0

/*while not @interval between 100 and 300 
	begin
set @interval=(select rand()*100)
end*/

--if @interval > 100 set @phonenumber ='+16622886110'
 set @phonenumber ='+18134699727'

 set @interval=100


 
set @schedulecount=(select count(*) from [Ryan].[Scheduler] where sent=0 and scheduleddate<getdate())

if @schedulecount>0
begin
set @scheduleid =(select top 1 id from [Ryan].[Scheduler] where sent=0 and scheduleddate<getdate() order by id desc)
update ryan.scheduler set sent=1 where id=@scheduleid 

set @message=(select task from ryan.scheduler where id =@scheduleid)
set @phonenumber=(select userphonenumber from ryan.scheduler where id= @scheduleid)
set @tosend=1
set @interval=5
end

 /*

set @phonenumber = '+16622886110'
set @tosend=1
set @message='CallMe'
set @interval=50


set @id =(SELECT TOP 1
      auto
   
  FROM [LTalk].[dbo].[Jokes]
  where length<120 and auto not in (select [idofcategorysent] from [LTalk].[PyLend].[SentItems] where [usernumber]=@phonenumber)
  order by newid()   )

  set @joke=(select joke from [LTalk].[dbo].[Jokes] where auto=@id)

  */
--sele

	insert into [PyLend].[HeartBeat] ([heartbeat]) values (@interval)

select @interval as [output], @phonenumber as [from],@message as [body], @tosend as sendstatus
    -- Insert statements for procedure here

END
GO
