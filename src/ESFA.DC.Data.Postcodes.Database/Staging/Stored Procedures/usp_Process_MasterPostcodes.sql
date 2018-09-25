CREATE PROCEDURE [Staging].[usp_Process_MasterPostcodes]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[MasterPostcodes] AS Target
		USING (
				SELECT DISTINCT PostCode
				FROM
				(
						  SELECT PostCode FROM [Staging].[ONS_Postcodes]
					UNION SELECT PostCode FROM [Staging].[DAS_PostcodeDisadvantage]
					UNION SELECT PostCode FROM [Staging].[EFA_PostcodeAreaCost]
					UNION SELECT PostCode FROM [Staging].[EFA_PostcodeDisadvantage]
					UNION SELECT PostCode FROM [Staging].[SFA_PostcodeAreaCost]
					UNION SELECT PostCode FROM [Staging].[SFA_PostcodeDisadvantage]
					UNION SELECT PostCode FROM [Staging].[CareerLearningPilot_Postcode]
					UNION SELECT PostCode FROM [Staging].[HMPP_Postcodes]
				) as PC
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]			
		WHEN NOT MATCHED BY TARGET THEN
			INSERT ( [Postcode] )
			VALUES ( Source.[Postcode] )
		--WHEN NOT MATCHED BY SOURCE THEN DELETE
		;

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