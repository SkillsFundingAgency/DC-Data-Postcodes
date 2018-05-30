CREATE TABLE [Staging].[DAS_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(8) NOT NULL, 
    [Uplift] DECIMAL(10, 5) NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL 
)
