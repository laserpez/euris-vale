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
        public string UserName { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public virtual List<Event> AttendingEvents { get; set; }
        public virtual List<Project> AttendingProjects { get; set; }
        public virtual List<Event> OrganizedEvents { get; set; }
        public virtual List<Project> OrganizedProjects { get; set; }
        public virtual List<Activity> PendingActivity { get; set; }
        public virtual List<Intervention> Interventions { get; set; }
        public virtual List<Group> JoinedGroups { get; set; }
        public override bool Equals(object obj)
        {
            var userData = (UserData)obj;
            return this.UserName == userData.UserName;
        }
        public override int GetHashCode()
        {
            return UserName.GetHashCode();
        }
    }
}