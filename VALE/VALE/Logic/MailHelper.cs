using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class MailHelper
    {
        public ILoggerEmail logger { get; set; }

        public MailHelper()
        {
            logger = LogFactoryEmail.GetCurrentLoggerEmail();
        }

        public string SendMail(Mail mailTosend)
        {
            try
            {
                MailMessage mMailMessage = new MailMessage();
                mMailMessage.From = new MailAddress(mailTosend.From);
                mMailMessage.To.Add(new MailAddress(mailTosend.To));
                if (!String.IsNullOrEmpty(mailTosend.BCC))
                    mMailMessage.Bcc.Add(new MailAddress(mailTosend.BCC));
                if (!String.IsNullOrEmpty(mailTosend.CC))
                    mMailMessage.CC.Add(new MailAddress(mailTosend.CC));
                mMailMessage.Subject = mailTosend.Subject;
                mMailMessage.Body = mailTosend.Body;
                mMailMessage.Priority = MailPriority.Normal;
                mMailMessage.IsBodyHtml = true;

                SmtpClient mSmtpClient = new SmtpClient();
                mSmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                mSmtpClient.Send(mMailMessage);

                return null;
            }
            catch (Exception ex)
            {
                Exception ex2 = ex;
                var ErrorMessage = String.Empty;
                while (ex2 != null)
                {
                   ErrorMessage += ex2.ToString();
                   ex2 = ex2.InnerException;
                }

                return ErrorMessage;
            }
        }

        public int AddToQueue(Mail mMailMessage)
        {
            try
            {
                var db = new UserOperationsContext();

                var newElementToQueue = new MailQueue
                {
                    Form = mMailMessage.Form,
                    Date = DateTime.Now,
                    mMail = mMailMessage,
                    Sent = false
                };

                db.MailQueues.Add(newElementToQueue);
                db.SaveChanges();

                return newElementToQueue.MailQueueId;
            }
            catch (Exception ex)
            {
                Exception ex2 = ex;
                string ErrorMessage = String.Empty;
                while (ex2 != null)
                {
                    ErrorMessage += ex2.ToString();
                    ex2 = ex2.InnerException;
                }

                return 0;
            }
        }

        public bool WriteLog(Mail mMailMessage, int queueId)
        {
            try
            {
                if (queueId != 0)
                {
                    var db = new UserOperationsContext();
                    var queueSelected = db.MailQueues.FirstOrDefault(m => m.MailQueueId == queueId);

                    logger.Write(new LogEntryEmail()
                        {
                            DataType = mMailMessage.Form,
                            DataAction = mMailMessage.Subject,
                            Sender = mMailMessage.From,
                            Receiver = mMailMessage.To,
                            Error = "Non ci sono messaggi d'errore",
                            Status = EmailStatus.Pending,
                            Date = DateTime.Now,
                            MailQueueId = queueSelected.MailQueueId
                        }
                        );

                    return true;
                }
                else
                    return false;
            }
            catch (Exception ex)
            {
                Exception ex2 = ex;
                string ErrorMessage = String.Empty;
                while (ex2 != null)
                {
                    ErrorMessage += ex2.ToString();
                    ex2 = ex2.InnerException;
                }

                return false;
            }
        }

        public bool UpdateLog(string error, List<MailQueue> listMailSent)
        {
            try
            {
                var db = new UserOperationsContext();

                foreach (var mailInList in listMailSent)
                {
                    var logSelected = db.LogEntriesEmail.FirstOrDefault(l => l.RelatedMailInQueue.MailQueueId == mailInList.MailQueueId);
                    if (logSelected != null)
                    {
                        if (String.IsNullOrEmpty(error))
                        {
                            logSelected.Status = EmailStatus.Sent;
                            logSelected.Error = "Invio con successo, non ci sono messaggi d'errore";
                        }
                        else
                        {
                            logSelected.Status = EmailStatus.Rejected;
                            logSelected.Error = error;
                        }

                        db.SaveChanges();
                    }
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public void Cleaner()
        {
            var db = new UserOperationsContext();
            List<MailQueue> emailQueue = db.MailQueues.Where(l => l.Sent == true).ToList();
            if (emailQueue.Count != 0)
                db.MailQueues.RemoveRange(emailQueue);
            db.SaveChanges();
        }
    }
}