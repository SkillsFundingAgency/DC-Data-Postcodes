CREATE PROCEDURE [Staging].[usp_Process]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
				

			RAISERROR('MasterPostcode',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_MasterPostcodes];

			RAISERROR('HMPP',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_HMPP_Postcodes];

			RAISERROR('CareerLearning',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_CareerLearningPilot_Postcode];

			RAISERROR('DAS',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_DAS_PostcodeDisadvantage];

			RAISERROR('EFA_PostcodeAreaCost',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_EFA_PostcodeAreaCost];

			RAISERROR('EFA_PostcodeDisadvantage',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_EFA_PostcodeDisadvantage];

			
			RAISERROR('ONS',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_ONS_Postcodes];

			RAISERROR('SFA_PostcodeAreaCost',10,1) WITH NOWAIT;
			EXEC [Staging].[usp_Process_SFA_PostcodeAreaCost];

			RAISERROR('SFA_PostcodeDisadvantage',10,1) WITH NOWAIT;
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