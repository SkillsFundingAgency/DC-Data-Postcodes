CREATE PROCEDURE [Staging].[usp_Process_ONS_Postcodes]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		MERGE INTO [dbo].[ONS_Postcodes] AS Target
		USING (
				SELECT  [Postcode]
					   ,[Introduction]
					   ,[Termination]
					   ,[LocalAuthority]
					   ,[Lep1]
					   ,[Lep2]
					   ,[EffectiveFrom]
					   ,[EffectiveTo]
					   ,[Nuts]
				  FROM [Staging].[ONS_Postcodes]
			  )
			  AS Source 
		    ON Target.[Postcode] = Source.[Postcode]
	      AND Target.[EffectiveFrom] = Source.[EffectiveFrom]	
			WHEN MATCHED 
				AND EXISTS 
					(	SELECT 
							 Target.[Introduction]
							,Target.[Termination]
							,Target.[LocalAuthority]
							,Target.[Lep1]
							,Target.[Lep2]
							,Target.[EffectiveTo]
							,Target.[Nuts]							
					EXCEPT 
						SELECT 
							 Source.[Introduction]
							,Source.[Termination]
							,Source.[LocalAuthority]
							,Source.[Lep1]
							,Source.[Lep2]
							,Source.[EffectiveTo]
							,Source.[Nuts]		
					)
		  THEN
			UPDATE SET   
				 [Introduction] = Source.[Introduction]
				,[Termination] = Source.[Termination]
				,[LocalAuthority] = Source.[LocalAuthority]
				,[Lep1] = Source.[Lep1]
				,[Lep2] = Source.[Lep2]
				,[EffectiveTo] = Source.[EffectiveTo]
				,[Nuts] = Source.[Nuts]
		WHEN NOT MATCHED BY TARGET THEN
		INSERT (       [Postcode]
					  ,[Introduction]
					  ,[Termination]
					  ,[LocalAuthority]
					  ,[Lep1]
					  ,[Lep2]
					  ,[EffectiveFrom]
					  ,[EffectiveTo]
					  ,[Nuts]
					)
			VALUES ( Source.[Postcode]
					,Source.[Introduction]
					,Source.[Termination]
					,Source.[LocalAuthority]
					,Source.[Lep1]
					,Source.[Lep2]
					,Source.[EffectiveFrom]
					,Source.[EffectiveTo]
					,Source.[Nuts]
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