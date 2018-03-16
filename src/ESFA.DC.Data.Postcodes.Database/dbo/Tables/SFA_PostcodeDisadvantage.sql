CREATE TABLE [dbo].[SFA_PostcodeDisadvantage]
(
	[Postcode] NVARCHAR(8) NOT NULL PRIMARY KEY, 
    [Uplift] DECIMAL(10, 5) NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL, 
    [Apprenticeship_Uplift] DECIMAL(7, 2) NULL, 
    CONSTRAINT [FK_SFA_PostcodeDisadvantage_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [Postcodes]([Postcode])
)
