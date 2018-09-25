CREATE PROCEDURE [Staging].[usp_Process_SFA_PostcodeAreaCost]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[SFA_PostcodeAreaCost] AS Target
		USING (
				SELECT  [Postcode] , 
						[AreaCostFactor], 
						[EffectiveFrom], 
						[EffectiveTo]
				  FROM [Staging].[SFA_PostcodeAreaCost]
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]
	      AND Target.[EffectiveFrom] = Source.[EffectiveFrom]	
			WHEN MATCHED 
				AND EXISTS 
					(	SELECT 
							 Target.[AreaCostFactor],					
							 Target.[EffectiveTo]							
					EXCEPT 
						SELECT 
							 Source.[AreaCostFactor],
							 Source.[EffectiveTo]
					)
		  THEN
			UPDATE SET   
				 [AreaCostFactor] = Source.[AreaCostFactor]			
				,[EffectiveTo] = Source.[EffectiveTo]						
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (     [Postcode]
					,[AreaCostFactor]
					,[EffectiveFrom]
					,[EffectiveTo]
					)
			VALUES ( Source.[Postcode]
					,Source.[AreaCostFactor]
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

GO
