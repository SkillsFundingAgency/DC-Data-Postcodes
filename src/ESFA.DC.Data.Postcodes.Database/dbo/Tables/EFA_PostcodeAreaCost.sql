CREATE TABLE [dbo].[EFA_PostcodeAreaCost]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [AreaCostFactor] DECIMAL(10, 5) NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL, 
    PRIMARY KEY ([Postcode], [EffectiveFrom]), 
    CONSTRAINT [FK_EFA_PostcodeAreaCost_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [MasterPostcodes]([Postcode])
)
