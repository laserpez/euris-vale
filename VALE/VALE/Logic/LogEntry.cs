using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Logic
{
    public class LogEntry
    {
        public int LogEntryId { get; set; }

        public int DataId { get; set; }

        public string DataType { get; set; }

        public string DataAction { get; set; }

        public string Description { get; set; }

        public string Username { get; set; }

        public DateTime Date { get; set; }
    }
}