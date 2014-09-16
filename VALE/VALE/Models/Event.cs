using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class Event
    {
        // Primary key
        public int EventId { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }
        public string Site { get; set; }
        public string Durata { get; set; }
        public bool Public { get; set; }
        public DateTime EventDate { get; set; }
        public virtual List<AttachedFile> AttachedFiles { get; set; }

        // Nullable FK, cascade deleting is set in modelBuilder
        [ForeignKey("RelatedProject")]
        public int? ProjectId { get; set; }
        public virtual Project RelatedProject { get; set; }

        // Many to many relationship defined in modelBuilder  (with delete cascade)
        public virtual List<UserData> PendingUsers { get; set; }

        // Many to many relationship defined in modelBuilder (with delete cascade)
        public virtual List<UserData> RegisteredUsers { get; set; }

        [ForeignKey("Organizer")]
        public string OrganizerUserName { get; set; }
        public virtual UserData Organizer { get; set; }
        
    }
}