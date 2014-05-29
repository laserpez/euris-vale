using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class ActivityReport
    {
        public int ActivityReportId { get; set; }
        public string ActivityDescription { get; set; }
        public DateTime Date { get; set; }
        public int HoursWorked { get; set; }

        [Required, ForeignKey("WorkedActivity")]
        public int ActivityId { get; set; }
        public virtual Activity WorkedActivity { get; set; }

        [Required, ForeignKey("Worker")]
        public string WorkerId { get; set; }
        public virtual UserData Worker { get; set; }

        
    }
}