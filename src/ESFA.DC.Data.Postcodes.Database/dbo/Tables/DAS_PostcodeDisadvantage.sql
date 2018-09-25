CREATE TABLE [dbo].[DAS_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(8) NOT NULL, 
    [Uplift] DECIMAL(10, 5) NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL 
    CONSTRAINT [FK_DAS_PostcodeDisadvantage_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [MasterPostcodes]([Postcode]), 
    PRIMARY KEY ([Postcode], [EffectiveFrom])
)
