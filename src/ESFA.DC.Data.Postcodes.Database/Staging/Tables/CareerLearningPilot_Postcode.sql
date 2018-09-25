CREATE TABLE [Staging].[CareerLearningPilot_Postcode]
(
	[Postcode] NVARCHAR(10) NOT NULL, 
	[AreaCode] NVARCHAR(50) NOT NULL, 
	[EffectiveFrom] DATE NOT NULL, 
	[EffectiveTo] DATE NULL
)
GO
GRANT ALTER ON OBJECT::Staging.CareerLearningPilot_Postcode TO [PostCode_RW_User];