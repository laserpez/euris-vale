using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class PartnerType
    {
        public int PartnerTypeId { get; set; }
        public string PartnerTypeName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }

        public override bool Equals(object obj)
        {
            var projectType = (ProjectType)obj;
            return this.PartnerTypeId == projectType.ProjectTypeId;
        }

        public override int GetHashCode()
        {
            return PartnerTypeId.GetHashCode();
        }
    }
}