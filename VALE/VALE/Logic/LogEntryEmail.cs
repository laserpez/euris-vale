using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace VALE.Logic
{
    public class LogEntryEmail
    {
        public int LogEntryEmailId { get; set; }

        public int DataId { get; set; }

        public string DataType { get; set; }

        public string DataAction { get; set; }

        public string Description { get; set; }

        public string Sender { get; set; }

        public string Receiver { get; set; }

        public string Error { get; set; }

        public string Form { get; set; }

        public bool Sent { get; set; }

        public DateTime Date { get; set; }
    }
}