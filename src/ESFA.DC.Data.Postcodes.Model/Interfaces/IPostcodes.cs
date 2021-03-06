﻿using System.Data.Entity;

namespace ESFA.DC.Data.Postcodes.Model.Interfaces
{
    public interface IPostcodes
    {
        DbSet<CareerLearningPilot_Postcode> CareerLearningPilot_Postcode { get; set; }
        DbSet<DAS_PostcodeDisadvantage> DAS_PostcodeDisadvantage { get; set; }
        DbSet<EFA_PostcodeAreaCost> EFA_PostcodeAreaCost { get; set; }
        DbSet<EFA_PostcodeDisadvantage> EFA_PostcodeDisadvantage { get; set; }
        DbSet<MasterPostcode> MasterPostcodes { get; set; }
        DbSet<ONS_Postcodes> ONS_Postcodes { get; set; }
        DbSet<SFA_PostcodeAreaCost> SFA_PostcodeAreaCost { get; set; }
        DbSet<SFA_PostcodeDisadvantage> SFA_PostcodeDisadvantage { get; set; }
        DbSet<HMPP_Postcodes> HMPP_Postcodes { get; set; }
        DbSet<VersionInfo> VersionInfos { get; set; }
    }
}
