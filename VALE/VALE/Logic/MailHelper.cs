using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace VALE.Logic
{
    public static class MailHelper
    {
        public static void SendMail(string email, string message, string subject)
        {
            var emailMessage = new MailMessage();
            emailMessage.From = new MailAddress("vale.donotreply@gmail.com");
            emailMessage.To.Add(new MailAddress(email));
            emailMessage.Subject = subject;
            emailMessage.Body = message;

            var smtpClient = new SmtpClient();
            smtpClient.EnableSsl = true;
            
            smtpClient.Send(emailMessage);
        }
    }
}