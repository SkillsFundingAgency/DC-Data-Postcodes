CREATE PROCEDURE [Staging].[usp_Process_DAS_PostcodeDisadvantage]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[DAS_PostcodeDisadvantage] AS Target
		USING (
				SELECT  [Postcode] , 
						[Uplift], 
						[EffectiveFrom], 
						[EffectiveTo]
				  FROM [Staging].[DAS_PostcodeDisadvantage]
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]
	      AND Target.[EffectiveFrom] = Source.[EffectiveFrom]	
			WHEN MATCHED 
				AND EXISTS 
					(	SELECT 
							 Target.[Uplift],					
							 Target.[EffectiveTo]							
					EXCEPT 
						SELECT 
							 Source.[Uplift],
							 Source.[EffectiveTo]
					)
		  THEN
			UPDATE SET   
				 [Uplift] = Source.[Uplift]			
				,[EffectiveTo] = Source.[EffectiveTo]						
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (     [Postcode]
					,[Uplift]
					,[EffectiveFrom]
					,[EffectiveTo]
					)
			VALUES ( Source.[Postcode]
					,Source.[Uplift]
					,Source.[EffectiveFrom]
					,Source.[EffectiveTo]
				  )
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