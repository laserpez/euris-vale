using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class Comment
    {
        public int CommentId { get; set; }
        public string CommentText { get; set; }
        public DateTime Date { get; set; }

        [ForeignKey("Creator")]
        public string CreatorId { get; set; }
        public virtual UserData Creator { get; set; }

        [Required, ForeignKey("RelatedIntervention")]
        public int InterventionId { get; set; }
        public virtual Intervention RelatedIntervention { get; set; }
    }
}