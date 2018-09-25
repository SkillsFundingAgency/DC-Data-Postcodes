CREATE TABLE [Staging].[HMPP_Postcodes]
(
	[Postcode] NVARCHAR(10) NOT NULL , 
    [UKPRN] BIGINT NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL    
)
GO
GRANT ALTER ON OBJECT::Staging.HMPP_Postcodes TO [PostCode_RW_User];
