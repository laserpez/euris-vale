using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class UserData
    {
        [Key]
        public string UserDataId { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }

        public virtual List<Event> AttendingEvents { get; set; }
        public virtual List<Project> AttendingProjects { get; set; }

        public virtual List<Event> OrganizedEvents { get; set; }
        public virtual List<Project> OrganizedProjects { get; set; }

        public virtual List<Activity> PendingActivity { get; set; }

        public virtual List<Intervention> Interventions { get; set; }
        
    }
}