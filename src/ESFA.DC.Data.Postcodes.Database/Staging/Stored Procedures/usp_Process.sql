CREATE PROCEDURE [Staging].[usp_Process]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
				
			EXEC [Staging].[usp_Process_MasterPostcodes];
			EXEC [Staging].[usp_Process_HMPP_Postcodes];
			EXEC [Staging].[usp_Process_CareerLearningPilot_Postcode];
			EXEC [Staging].[usp_Process_DAS_PostcodeDisadvantage];
			EXEC [Staging].[usp_Process_EFA_PostcodeAreaCost];
			EXEC [Staging].[usp_Process_EFA_PostcodeDisadvantage];

			EXEC [Staging].[usp_Process_ONS_Postcodes];

			EXEC [Staging].[usp_Process_SFA_PostcodeAreaCost];
			EXEC [Staging].[usp_Process_SFA_PostcodeDisadvantage];

		RETURN 0;

	END TRY
-- 
-------------------------------------------------------------------------------------- 
-- Handle any problems
-------------------------------------------------------------------------------------- 
-- 
	BEGIN CATCH

		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
						
		SELECT	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= 'Error in :' + ISNULL(OBJECT_NAME(@@PROCID),'') + ' - Error was :' + ERROR_MESSAGE()
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();
	
		RAISERROR (
					  @ErrorMessage		-- Message text.
					, @ErrorSeverity	-- Severity.
					, @ErrorState		-- State.
				  );
			  
		RETURN @ErrorNumber;

	END CATCH
-- 
-------------------------------------------------------------------------------------- 
-- All done
-------------------------------------------------------------------------------------- 
-- 
END