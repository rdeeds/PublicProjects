SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION ryan.FD_Trivia_answer 
(
	@a nvarchar(100),@b nvarchar(100), @c nvarchar(100), @d nvarchar(100), @answer nvarchar(100)
)
RETURNS int
AS
BEGIN

declare @return int
set @return=0
if @a=@answer set @return=1

if @b=@answer set @return=2

if @c=@answer set @return=3

if @d=@answer set @return=4
	
	-- Add the T-SQL statements to compute the return value here


	-- Return the result of the function
	RETURN @return
END
GO
