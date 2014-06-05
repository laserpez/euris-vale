using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class Intervention
    {
        public int InterventionId { get; set; }
        public string InterventionText { get; set; }
        public string DocumentsPath { get; set; }
        public DateTime Date { get; set; }

        [Required, ForeignKey("Creator")]
        public string CreatorUserName { get; set; }
        public virtual UserData Creator { get; set; }

        [Required, ForeignKey("RelatedProject")]
        public int ProjectId { get; set; }
        public virtual Project RelatedProject { get; set; }

        public virtual List<Comment> Comments { get; set; }
    }
}