using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class Project
    {

        // Primary key
        public int ProjectId { get; set; }

        public string ProjectName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime LastModified { get; set; }
        public string Status { get; set; }
        public bool Public { get; set; }
        public virtual List<AttachedFile> AttachedFiles { get; set; }
        // 0-n relationship with table Activity
        public virtual List<Activity> Activities { get; set; }

        // 0-n relationship with table Event
        public virtual List<Event> Events { get; set; }

        // 0-n relationship with table Intervention
        public virtual List<Intervention> Interventions { get; set; }

        // Many to many relationship defined in modelBuilder
        public virtual List<UserData> InvolvedUsers { get; set; }

        // Foreign key on UserData table - organizer id
        [ForeignKey("Organizer")]
        public string OrganizerUserName { get; set; }
        public virtual UserData Organizer { get; set; }

        public virtual Project RelatedProject { get; set; }

    }
}