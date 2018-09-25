CREATE TABLE [Staging].[DAS_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(10) NOT NULL, 
    [Uplift] DECIMAL(10, 5) NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL 
)
GO
GRANT ALTER ON OBJECT::Staging.DAS_PostcodeDisadvantage TO [PostCode_RW_User];
