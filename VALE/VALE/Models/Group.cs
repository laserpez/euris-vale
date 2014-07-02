using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class Group
    {
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public virtual List<UserData> Users { get; set; }

        public override bool Equals(object obj)
        {
            var group = (Group)obj;
            return this.GroupId == group.GroupId;
        }

        public override int GetHashCode()
        {
            return GroupId.GetHashCode();
        }
    }
}