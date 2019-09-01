CREATE procedure [dbo].[sp_log_event] (
	@Level AS int,
	@Context AS NVARCHAR(max),
	@Text AS NVARCHAR(max)
) 
AS
BEGIN

    SET NOCOUNT ON

    /*
    ** Declarations.
    */
    DECLARE @retcode int=0
 
	INSERT dbo.Logs VALUES (@Level, @Context, @Text)
	return @retcode
END