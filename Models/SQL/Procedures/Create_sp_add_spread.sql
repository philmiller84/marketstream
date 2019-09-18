CREATE procedure [dbo].[sp_add_spread] (
	@bidPrice decimal(18, 2),
	@askPrice decimal (18, 2),
	@Sequence bigint 
) 
AS
BEGIN

    SET NOCOUNT ON

    /*
    ** Declarations.
    */
    DECLARE @retcode int=0
            
	-------------------= CREATE SPREADS =-------------------- 
          
	--check if current spread
	DECLARE @s_id INTEGER=NULL
	SELECT @s_id = s.spreadId FROM [dbo].[Spreads] s WHERE s.Status = 0 --Status values:= NULL (undefined), 0 (started), 1 (finished)

	--if no current spread, start spread
	IF @s_id IS NULL

	BEGIN
	-- Check if the size of the spread is greater than the minimum price increment

		INSERT INTO [dbo].[Spreads]
		SELECT @Sequence		--[StartSequence]
			,@Sequence			--[EndSequence]
			,@bidPrice			--[BidPrice]		
			,@askPrice			--[AskPrice]
			,0					--[Status]

	END
	ELSE IF @s_id IS NOT NULL -- we have a spread!!!
	BEGIN
		DECLARE @isAbortSpread INTEGER=0

		SELECT @isAbortSpread = IIF(@bidPrice <> s.bidPrice OR @askPrice <> s.askPrice, 1, 0)
		FROM [dbo].[Spreads] s
		WHERE s.spreadId = @s_id

		IF @isAbortSpread = 1 -- aborting spread
		BEGIN
			--Update existing spread
			UPDATE [dbo].[Spreads] SET Status = 1 FROM [dbo].[Spreads] s WHERE s.spreadId = @s_id

			DECLARE @SpreadStrategy INT = 1

			----TODO: Adjust sell increment based on the performance of the spread
			----Adjust Sell increment for new sell orders
			--UPDATE sp 
			--SET sp.Value = @askPrice - @bidPrice
			--FROM dbo.StrategyProperties sp
			--WHERE sp.StrategyType = @SpreadStrategy AND sp.Description = 'Sell Increment' 

			--TODO: Adjust existing sell orders
		
			---- Create new spread element
			INSERT INTO [dbo].[Spreads]
			SELECT s.EndSequence		--[StartSequence]
				  ,@Sequence			--[EndSequence]
				  ,@bidPrice			--[BidPrice]
				  ,@askPrice			--[AskPrice]
				  ,0				--[Status]
			FROM [dbo].[Spreads] s
			WHERE s.spreadId = @s_id
		END
	END

	return @retcode
END