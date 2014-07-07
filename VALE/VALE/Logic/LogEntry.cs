using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace VALE.Logic
{
    public class LogEntry
    {
        public int LogEntryId { get; set; }

        public int DataId { get; set; }

        public string DataType { get; set; }

        [NotMapped]
        public string DataTypeUrl
        {
            get
            {
                switch(DataType)
                {
                    case "Evento":
                        return "glyphicon glyphicon-inbox";
                    case "Progetto":
                        return "glyphicon glyphicon-flash";
                    case "Attività":
                        return "glyphicon glyphicon-list";
                    default:
                        return "glyphicon glyphicon-remove";
                };
            }
        }

        public string DataAction { get; set; }

        public string Description { get; set; }

        public string Username { get; set; }

        public DateTime Date { get; set; }
    }
}