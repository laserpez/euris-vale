using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class Activity
    {
        // Primary key
        public int ActivityId { get; set; }

        public string ActivityName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime? ExpireDate { get; set; }
        public ActivityStatus Status { get; set; }

        // Nullable FK, cascade deleting is set in modelBuilder
        [ForeignKey("RelatedProject")]
        public int? ProjectId { get; set; }
        public virtual Project RelatedProject { get; set; }

        // Many to many relationship defined in modelBuilder  (with delete cascade)
        public virtual List<UserData> PendingUsers { get; set; }
        
        [ForeignKey("Creator")]
        public string CreatorUserName { get; set; }
        public virtual UserData Creator { get; set; }
    }

    public enum ActivityStatus
    {
        Planned,
        Ongoing,
        Suspended,
        Deleted,
        Ended
    }
}