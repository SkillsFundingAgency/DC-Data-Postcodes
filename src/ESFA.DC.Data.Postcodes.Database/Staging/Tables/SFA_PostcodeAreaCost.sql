﻿CREATE TABLE [Staging].[SFA_PostcodeAreaCost]
(
	[Postcode] NVARCHAR(10) NOT NULL , 
    [AreaCostFactor] DECIMAL(10, 5) NOT NULL, 
    [EffectiveFrom] DATE NOT NULL, 
    [EffectiveTo] DATE NULL
)

GO
GRANT ALTER ON OBJECT::Staging.SFA_PostcodeAreaCost TO [PostCode_RW_User];