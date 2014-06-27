using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class AttachedFile
    {
        public int AttachedFileID { get; set; }
        public string FileName { get; set; }
        public string FileDescription { get; set; }
        public string FileExtension { get; set; }
        public DateTime CreationDate { get; set; }
        public string Owner { get; set; }
        public byte[] FileData { set; get; }

        [ForeignKey("RelatedProject")]
        public int? ProjectId { get; set;}
        public virtual Project RelatedProject { get; set; }

        [ForeignKey("RelatedEvent")]
        public int? EventId { get; set; }
        public virtual Event RelatedEvent { get; set; }

        [ForeignKey("RelatedIntervention")]
        public int? InterventionId { get; set; }
        public virtual Intervention RelatedIntervention { get; set; }

        [ForeignKey("RelatedBODReport")]
        public int? BODReportId { get; set; }
        public virtual Intervention RelatedBODReport { get; set; }
    }
}