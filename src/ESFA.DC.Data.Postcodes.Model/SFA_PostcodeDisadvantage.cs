//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ESFA.DC.Data.Postcodes.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class SFA_PostcodeDisadvantage
    {
        public string Postcode { get; set; }
        public Nullable<decimal> Uplift { get; set; }
        public System.DateTime EffectiveFrom { get; set; }
        public Nullable<System.DateTime> EffectiveTo { get; set; }
        public Nullable<decimal> Apprenticeship_Uplift { get; set; }
    
        public virtual MasterPostcode MasterPostcode { get; set; }
    }
}
