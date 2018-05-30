CREATE TABLE [Staging].[ONS_Postcodes]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [Introduction] NVARCHAR(6) NULL, 
    [Termination] NVARCHAR(6) NULL, 
    [LocalAuthority] NVARCHAR(9) NULL, 
    [Lep1] NVARCHAR(9) NULL, 
    [Lep2] NVARCHAR(9) NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL, 
    [Nuts] NVARCHAR(10) NULL, 
)
