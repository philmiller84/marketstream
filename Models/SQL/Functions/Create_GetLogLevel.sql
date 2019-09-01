CREATE FUNCTION GetLogLevel()
RETURNS int WITH SCHEMABINDING
BEGIN
DECLARE @logLevel INT = 0
SELECT @logLevel = Value FROM dbo.Globals WHERE Description = 'Logging Enabled'
RETURN @logLevel
END
GO
