CREATE TABLE [dbo].[CareerLearningPilot_Postcode]
(
	[Postcode] NVARCHAR(8) NOT NULL, 
	[AreaCode] NVARCHAR(50) NOT NULL, 
	[EffectiveFrom] DATE NOT NULL, 
	[EffectiveTo] DATE NULL, 
	PRIMARY KEY ([Postcode], [EffectiveFrom]),
	CONSTRAINT [FK_CareerLearningPilot_Postcodes] FOREIGN KEY ([Postcode]) REFERENCES [MasterPostcodes]([Postcode])
)