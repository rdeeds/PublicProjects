SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION ryan.comp
(

@a nvarchar(100), @b nvarchar(100)

)
RETURNS bit
AS
BEGIN

declare @return bit

set @return =0

if @a=@b set @return=1

return @return

END
GO
