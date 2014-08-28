using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class ActivityType
    {
        public int ActivityTypeId { get; set; }
        public string ActivityTypeName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }

        public override bool Equals(object obj)
        {
            var activityType = (ActivityType)obj;
            return this.ActivityTypeId == activityType.ActivityTypeId;
        }

        public override int GetHashCode()
        {
            return ActivityTypeId.GetHashCode();
        }
    }
}