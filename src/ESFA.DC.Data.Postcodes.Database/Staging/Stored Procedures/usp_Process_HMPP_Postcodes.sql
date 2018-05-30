﻿CREATE PROCEDURE [Staging].[usp_Process_HMPP_Postcodes]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[HMPP_Postcodes] AS Target
		USING (
				SELECT  [Postcode] , 
						[UKPRN], 
						[EffectiveFrom], 
						[EffectiveTo]
				  FROM [Staging].[HMPP_Postcodes]
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]
	      AND Target.[UKPRN] = Source.[UKPRN]	
	      AND Target.[EffectiveFrom] = Source.[EffectiveFrom]	
			WHEN MATCHED 
				AND EXISTS 
					(	SELECT 
							 Target.[EffectiveTo]							
					EXCEPT 
						SELECT 
							 Source.[EffectiveTo]
					)
		  THEN
			UPDATE SET   [EffectiveTo] = Source.[EffectiveTo]						
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (     [Postcode]
					,[UKPRN]
					,[EffectiveFrom]
					,[EffectiveTo]
					)
			VALUES ( Source.[Postcode]
					,Source.[UKPRN]
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