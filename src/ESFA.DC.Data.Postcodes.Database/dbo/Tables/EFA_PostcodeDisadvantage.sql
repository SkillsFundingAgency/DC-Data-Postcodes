CREATE TABLE [dbo].[EFA_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [Uplift] DECIMAL(10, 5) NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL, 
    PRIMARY KEY ([Postcode], [EffectiveFrom]), 
    CONSTRAINT [FK_EFA_PostcodeDisadvantage_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [MasterPostcodes]([Postcode])
)
