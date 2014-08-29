using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Net.Mail;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace VALE.Logic
{
    public class MailQueue
    {

        public int MailQueueId { get; set; }

        public string Form { get; set; }

        public DateTime Date { get; set; }

        public Mail mMail { get; set; }

        public bool Sent { get; set; }

    }
}