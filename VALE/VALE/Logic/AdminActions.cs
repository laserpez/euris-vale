using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public static class AdminActions
    {
        public static void ConfirmUser(string userName)
        {
            var db = new ApplicationDbContext();
            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(db));
            var userToConfirm = userManager.FindByName(userName);
            if (userToConfirm != null) 
            {
                userToConfirm.NeedsApproval = false;
                db.SaveChanges();
            }
        }
        
        public static int GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            return db.Users.Where(u => u.NeedsApproval == true).Count();
        }

        public static int GetWaitingArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles.Where(b => b.Status == "pending").Count();
        }

        public static bool ComposeMessage(ApplicationUserManager manager, string userId, string password, string subject)
        {
            try
            {
                switch (subject)
                {
                    case "Registrazione":
                        string code = manager.GenerateEmailConfirmationToken(userId);
                        string CallbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, userId);
                        var newUser = manager.FindById(userId);
                        using (var actions = new UserActions())
                        {
                            var admins = actions.GetFilteredData("Administrators");

                            var bodyMail = String.Empty;

                            //Invio e-mail aglli amministratori capi di sistema
                            foreach (var admin in admins)
                            {
                                var subjectMail = "Registrazione di un nuovo utente";
                                bodyMail = "Salve, ti informiamo che in data " + DateTime.Now.ToShortDateString() + " si è registrato al sito VALE l'utente " + newUser.UserName + ".";
                                Mail newMailAdmin = new Mail(to: admin.Email, bcc: "", cc: "", subject: subjectMail, body: bodyMail, form: "Registrazione");
                                AddToQueue(newMailAdmin);
                            }

                            ////Invio e-mail all'utente
                            //bodyMail = "Benvenuto in VALE.<br/> La registrazione è avvenuta con successo.<br/>Per favore conferma il tuo account cliccando <a href=\" http://localhost:59959/" + CallbackUrl + "\">qui</a>.";
                            //Mail newMailUser = new Mail(to: newUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Registrazione");
                            //AddToQueue(newMailUser);
                        }

                        break;
                    case "Invito a VALE":
                        string generatedCode = manager.GenerateEmailConfirmationToken(userId);
                        string generatedCallbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(generatedCode, userId);
                        var generatedUser = manager.FindById(userId);
                        using (var actions = new UserActions())
                        {
                            var admins = actions.GetFilteredData("Administrators");

                            var bodyMail = String.Empty;

                            //Invio e-mail agli amministratori capi di sistema
                            foreach (var admin in admins)
                            {
                                var subjectMail = "Registrazione di un nuovo utente";
                                bodyMail = "Salve, ti informiamo che in data " + DateTime.Now.ToShortDateString() + " è stata effettuata la registrazione al sito VALE dell'utente " + generatedUser.UserName + " da parte dell'Amministrazione.";
                                Mail newMailAdmin = new Mail(to: admin.Email, bcc: "", cc: "", subject: subjectMail, body: bodyMail, form: "Registrazione");
                                AddToQueue(newMailAdmin);
                            }

                            //Invio e-mail all'utente
                            bodyMail = "Benvenuto in VALE!<br/> Ti informiamo che in data " + DateTime.Now.ToShortDateString() + " l'amministrazione ti ha registrato come nuovo utente. La password di default con cui effettuare il Log In è:" + password + ". <br/> Potrai cambiarla una volta confermato l'account cliccando alla tua pagina di <a href=\" http://localhost:59959/Account/Profile" + "\"> Profilo <a/>";
                            Mail newMailUser = new Mail(to: generatedUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Registrazione");
                            AddToQueue(newMailUser);
                        }
                        break;
                    case "Conferma richiesta":
                        var UserConfirmed = manager.FindById(userId);
                        var bodyEmail = "Ti informiamo che la tua richiesta di associazione è stata accettata.<br/> Benvenuto tra i soci di VALE!";
                        Mail newMailUserConfirmed = new Mail(to: UserConfirmed.Email, bcc: "", cc: "", subject: subject, body: bodyEmail, form: "Registrazione");
                        AddToQueue(newMailUserConfirmed);
                        break;
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        private static void AddToQueue(Mail email)
        {
            var helper = new MailHelper();
            int queueId = helper.AddToQueue(email);
            helper.WriteLog(email, queueId);
        }

    }
}