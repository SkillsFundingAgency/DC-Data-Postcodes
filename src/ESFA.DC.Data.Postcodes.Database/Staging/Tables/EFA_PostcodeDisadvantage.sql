CREATE TABLE [Staging].[EFA_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(10) NOT NULL , 
    [Uplift] DECIMAL(10, 5) NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL
)

GO
GRANT ALTER ON OBJECT::Staging.EFA_PostcodeDisadvantage TO [PostCode_RW_User];