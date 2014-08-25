using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace VALE.Logic
{
    public class Mail
    {
        public string From { get; set; }
        public string To { get; set; }
        public string BCC { get; set; }
        public string CC { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public string Form { get; set; }

        public Mail()
        { 
        }

        public Mail(string to, string bcc, string cc, string subject, string body, string form)
        {
            this.From = ConfigurationManager.AppSettings["From"].ToString();
            this.To = to;
            this.BCC = bcc;
            this.CC = cc;
            this.Subject = subject;
            this.Body = body;
            this.Form = form;
        }
    }
}