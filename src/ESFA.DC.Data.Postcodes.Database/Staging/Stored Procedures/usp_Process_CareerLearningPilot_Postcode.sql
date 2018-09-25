CREATE PROCEDURE [Staging].[usp_Process_CareerLearningPilot_Postcode]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[CareerLearningPilot_Postcode] AS Target
		USING (
				SELECT  [Postcode] , 
						[AreaCode], 
						[EffectiveFrom], 
						[EffectiveTo]
				  FROM [Staging].[CareerLearningPilot_Postcode]
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]
	      AND Target.[EffectiveFrom] = Source.[EffectiveFrom]	
			WHEN MATCHED 
				AND EXISTS 
					(	SELECT 
							 Target.[AreaCode],					
							 Target.[EffectiveTo]							
					EXCEPT 
						SELECT 
							 Source.[AreaCode],
							 Source.[EffectiveTo]
					)
		  THEN
			UPDATE SET   
				 [AreaCode] = Source.[AreaCode]			
				,[EffectiveTo] = Source.[EffectiveTo]						
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (     [Postcode]
					,[AreaCode]
					,[EffectiveFrom]
					,[EffectiveTo]
					)
			VALUES ( Source.[Postcode]
					,Source.[AreaCode]
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