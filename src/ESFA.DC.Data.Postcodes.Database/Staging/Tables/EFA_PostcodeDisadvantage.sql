CREATE TABLE [Staging].[EFA_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [Uplift] DECIMAL(10, 5) NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL
)
