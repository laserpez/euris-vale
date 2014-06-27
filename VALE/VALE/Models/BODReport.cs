using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class BODReport
    {
        public int BODReportId { get; set; }
        public string Name { get; set; }
        public string Text { get; set; }
        public DateTime MeetingDate { get; set; }
        public string Location { get; set; }
        public DateTime PublishingDate { get; set; }
        public virtual List<AttachedFile> AttachedFiles { get; set; }
    }
}