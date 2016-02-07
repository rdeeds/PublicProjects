SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [Ryan].[IDGen](@id nvarchar(255),@len int)
RETURNS nvarchar(255)
AS
BEGIN

declare @randomstring nvarchar(255)

set @randomString = (select substring(replace(CONVERT(varchar(255), @id),'-',''),0,@len))




return @randomstring


END
GO
