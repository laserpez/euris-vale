using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Timers;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using VALE.Logic;
using VALE.Models;

namespace VALE
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            // Initialize the product database.
            String path = Server.MapPath("~/Logic/Serializable/Ruoli.xml");
            RoleActions.File = path;
            RoleActions.initializeRole();
            Database.SetInitializer(new DatabaseInitializer());
            using (var actions = new UserActions())
            {
                actions.CreateAdministrator();
            }

            // Create a timer.
            var aTimer = new Timer();
            aTimer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            aTimer.Interval = Convert.ToInt32(ConfigurationManager.AppSettings["Interval"].ToString());
            aTimer.Enabled = true;
        
        }

        private static void OnTimedEvent(object source, ElapsedEventArgs e)
        {
            var db = new UserOperationsContext();
            
            var dbData = new ApplicationDbContext();
            var allUsers = dbData.Users.ToList();
            foreach (var user in allUsers)
            {
                var allMailUser = db.MailQueues.Where(m => m.mMail.To == user.Email).ToList();
                SendAllMail(allMailUser, user.Email);
            }

            var helper = new MailHelper();
            helper.Cleaner();
         }


        private static void SendAllMail(List<MailQueue> allMailInQueue, string receiver)
        {
            var db = new UserOperationsContext();

            var bodyMail = "Salve, un aggiornamento delle ultime attività del sito VALE.<br/><br/>";

            List<MailQueue> listMailSent = new List<MailQueue>();

            var allMailRegisters = allMailInQueue.Where(m => m.Form == "Registrazione").ToList();
            var allMailProjects = allMailInQueue.Where(m => m.Form == "Progetto" && (m.mMail.Subject == "Invito di partecipazione ad un Progetto" || m.mMail.Subject == "Invito di partecipazione ad un Progetto" || m.mMail.Subject == "Richiesta partecipazione ad un Progetto" || m.mMail.Subject == "Rimozione partecipazione")).ToList();
            var allMailEvents = allMailInQueue.Where(m => m.Form == "Evento" && (m.mMail.Subject == "Invito di partecipazione ad un Evento" || m.mMail.Subject == "Richiesta partecipazione ad un Evento" || m.mMail.Subject == "Rimozione partecipazione")).ToList();
            var allMailActivities = allMailInQueue.Where(m => m.Form == "Attivita" && (m.mMail.Subject == "Invito a collaborare ad una Attività" || m.mMail.Subject == "Conferma collaborazione" || m.mMail.Subject == "Rifiuto collaborazione")).ToList();

            if (allMailRegisters.Count != 0)
            {
                foreach (var mail in allMailRegisters)
                {
                    bodyMail += mail.mMail.Body + "<br/><br/>";
                    allMailInQueue.Remove(mail);
                    listMailSent.Add(mail);
                }
            }

            if (allMailProjects.Count != 0)
            {
                foreach (var mail in allMailProjects)
                {
                    bodyMail += mail.mMail.Body + "<br/><br/>";
                    allMailInQueue.Remove(mail);
                    listMailSent.Add(mail);
                }
            }

            if (allMailEvents.Count != 0)
            {
                foreach (var mail in allMailEvents)
                {
                    bodyMail += mail.mMail.Body + "<br/><br/>";
                    allMailInQueue.Remove(mail);
                    listMailSent.Add(mail);
                }
            }

            if (allMailActivities.Count != 0)
            {
                foreach (var mail in allMailActivities)
                {
                    bodyMail += mail.mMail.Body + "<br/><br/>";
                    allMailInQueue.Remove(mail);
                    listMailSent.Add(mail);
                }
            }

            if (allMailInQueue.Count != 0)
            {
                foreach (var mail in allMailInQueue)
                {
                    bodyMail += mail.mMail.Body + "<br/><br/>";
                    listMailSent.Add(mail);
                }
            }
            var subjectMail = "Informazioni gruppo VALE del" + DateTime.Now.ToShortDateString();
            Mail newMail = new Mail(to: receiver, bcc: "", cc: "", subject: subjectMail, body: bodyMail, form: "");

            var helper = new MailHelper();
            var error = helper.SendMail(newMail);
            helper.UpdateLog(error, listMailSent);
            bodyMail = String.Empty;
        }        

    }
}