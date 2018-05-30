CREATE TABLE [Staging].[HMPP_Postcodes]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [UKPRN] BIGINT NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL    
)
