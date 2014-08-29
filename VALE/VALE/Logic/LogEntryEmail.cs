using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace VALE.Logic
{
    public class LogEntryEmail
    {
        public int LogEntryEmailId { get; set; }

        public string DataType { get; set; }

        [NotMapped]
        public string DataTypeUrl
        {
            get
            {
                switch (DataType)
                {
                    case "Evento":
                        return "glyphicon glyphicon-flash";
                    case "Progetto":
                        return "glyphicon glyphicon-inbox";
                    case "Attività":
                        return "glyphicon glyphicon-list";
                    case "Registrazione":
                        return "glyphicon glyphicon-user";
                    default:
                        return "glyphicon glyphicon-th";
                };
            }
        }

        public bool Read { get; set; }

        public string DataAction { get; set; }

        public string Receiver { get; set; }

        public string Error { get; set; }

        public string Body { get; set; }

        public EmailStatus Status { get; set; }

        public DateTime Date { get; set; }

        [ForeignKey("RelatedMailInQueue")]
        public int? MailQueueId { get; set; }
        public virtual MailQueue RelatedMailInQueue { get; set; }
    }

    public enum EmailStatus
    {
        Sent,
        Pending,
        Rejected
    }
}