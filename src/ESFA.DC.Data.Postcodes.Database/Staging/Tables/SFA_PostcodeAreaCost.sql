CREATE TABLE [Staging].[SFA_PostcodeAreaCost]
(
	[Postcode] NVARCHAR(8) NOT NULL , 
    [AreaCostFactor] DECIMAL(10, 5) NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL
)
