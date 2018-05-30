CREATE PROCEDURE [Staging].[usp_Process_MasterPostcodes]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[MasterPostcodes] AS Target
		USING (
				SELECT [Postcode]
				  FROM [Staging].[MasterPostcodes]
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]			
		WHEN NOT MATCHED BY TARGET THEN
			INSERT ( [Postcode] )
			VALUES ( Source.[Postcode] )
		WHEN NOT MATCHED BY SOURCE THEN DELETE
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