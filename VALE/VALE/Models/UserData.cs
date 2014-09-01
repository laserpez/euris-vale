﻿using System;
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
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string Region { get; set; }
        public string Province { get; set; }
        public string City { get; set; }
        public string CF { get; set; }
        public string Telephone { get; set; }
        public string CellPhone { get; set; }
        public bool NeedsApproval { get; set; }
        public string Description { get; set; }
        public string CVName { get; set; }
        public byte[] Document { get; set; }
        public byte[] PhotoProfile { get; set; }
        public string PartnerType { get; set; }

        public virtual List<Event> AttendingEvents { get; set; }
        public virtual List<Project> AttendingProjects { get; set; }
        public virtual List<Event> OrganizedEvents { get; set; }
        public virtual List<Project> OrganizedProjects { get; set; }
        public virtual List<Activity> PendingActivity { get; set; }
        public virtual List<Activity> AttendingActivities { get; set; }
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