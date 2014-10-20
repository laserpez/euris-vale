using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class Activity
    {
        // Primary key
        public int ActivityId { get; set; }
        public string ActivityName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? ExpireDate { get; set; }
        public DateTime LastModified { get; set; }
        public ActivityStatus Status { get; set; }
        public string Type { get; set; }
        public int Budget { get; set; }

        // Nullable FK, cascade deleting is set in modelBuilder
        [ForeignKey("RelatedProject")]
        public int? ProjectId { get; set; }
        public virtual Project RelatedProject { get; set; }

        // Many to many relationship defined in modelBuilder  (with delete cascade)
        public virtual List<UserData> PendingUsers { get; set; }

        // Many to many relationship defined in modelBuilder (with delete cascade)
        public virtual List<UserData> RegisteredUsers { get; set; }
        
        [ForeignKey("Creator")]
        public string CreatorUserName { get; set; }
        public virtual UserData Creator { get; set; }
        public virtual List<AttachedFile> AttachedFiles { get; set; }
    }

    public enum ActivityStatus
    {
        ToBePlanned,
        Ongoing,
        Suspended,
        Done,
        Deleted
    }
}