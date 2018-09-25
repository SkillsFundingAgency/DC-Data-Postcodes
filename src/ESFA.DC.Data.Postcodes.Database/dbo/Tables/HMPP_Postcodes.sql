CREATE TABLE [dbo].[HMPP_Postcodes]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [UKPRN] BIGINT NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL    
    CONSTRAINT [FK_HMPP_Postcodes_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [MasterPostcodes]([Postcode]), 
    PRIMARY KEY ([EffectiveFrom], [Postcode], [UKPRN])
)
