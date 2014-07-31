using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class SummaryIntervention : ActivityReport
    {
        public string ProjectName { get; set; }
        public string RelatedProjectName { get; set; }
        public string ActivityName { get; set; }
        public string ProjectType { get; set; }
        public string ActivityType { get; set; }
        public string ProjectPublic { get; set; }
        public string UserName { get; set; }
        public string UserGroup { get; set; }

    }
}