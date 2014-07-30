using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class SetGroups
    {
        public int SetGroupsId { get; set; }
        public string SetGroupsName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        public virtual List<Group> Groups { get; set; }
    }
}