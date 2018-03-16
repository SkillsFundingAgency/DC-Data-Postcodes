using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ESFA.DC.Data.Postcodes.Model.Interfaces
{
    interface IPostcodes
    {
        DbSet<EFA_PostcodeAreaCost> EFA_PostcodeAreaCost { get; set; }
        DbSet<EFA_PostcodeDisadvantage> EFA_PostcodeDisadvantage { get; set; }
        DbSet<MasterPostcode> MasterPostcodes { get; set; }
        DbSet<ONS_Postcodes> ONS_Postcodes { get; set; }
        DbSet<SFA_PostcodeAreaCost> SFA_PostcodeAreaCost { get; set; }
        DbSet<SFA_PostcodeDisadvantage> SFA_PostcodeDisadvantage { get; set; }
    }
}
