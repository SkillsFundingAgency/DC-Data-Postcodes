CREATE TABLE [dbo].[ONS_Postcodes]
(
	[Postcode] NVARCHAR(8) NOT NULL PRIMARY KEY, 
    [Introduction] NVARCHAR(6) NULL, 
    [Termination] NVARCHAR(6) NULL, 
    [LocalAuthority] NVARCHAR(9) NULL, 
    [Lep1] NVARCHAR(9) NULL, 
    [Lep2] NVARCHAR(9) NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL, 
    [Nuts] NVARCHAR(10) NULL, 
    CONSTRAINT [FK_ONS_Postcodes_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [MasterPostcodes]([Postcode])
)
