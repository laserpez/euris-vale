using System;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using System.Linq;
using VALE.Models;
using System.Collections.Generic;
using VALE.StateInfo;
using VALE.Logic;

namespace VALE.Account
{
    public partial class RegisterExternalLogin : System.Web.UI.Page
    {
        protected string ProviderName
        {
            get { return (string)ViewState["ProviderName"] ?? String.Empty; }
            private set { ViewState["ProviderName"] = value; }
        }

        protected string ProviderAccountKey
        {
            get { return (string)ViewState["ProviderAccountKey"] ?? String.Empty; }
            private set { ViewState["ProviderAccountKey"] = value; }
        }

        private void RedirectOnFail()
        {
            Response.Redirect((User.Identity.IsAuthenticated) ? "~/Account/Manage" : "~/Account/Login");
        }

        protected void Page_Load()
        {
            // Process the result from an auth provider in the request
            ProviderName = IdentityHelper.GetProviderNameFromRequest(Request);
            if (String.IsNullOrEmpty(ProviderName))
            {
                RedirectOnFail();
                return;
            }
            if (!IsPostBack)
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                if (loginInfo == null)
                {
                    RedirectOnFail();
                    return;
                }
                var user = manager.Find(loginInfo.Login);
                if (user != null)
                {
                    if (user.NeedsApproval)
                    {
                        string titleMessage = string.Format("{0} {1},", user.FirstName, user.LastName);
                        string message = string.Format("la tua richiesta non è ancora accettata, una mail di conferma verrà mandata all'indirizzo {0}, una volta confermata da un Amministratore.", user.Email);
                        string url = string.Format("~/MessagePage.aspx?TitleMessage={0}&Message={1}", titleMessage, message);
                        Response.Redirect(url);
                    }
                    else
                    {
                        IdentityHelper.SignIn(manager, user, isPersistent: false);
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                }
                else if (User.Identity.IsAuthenticated)
                {
                    // Apply Xsrf check when linking
                    var verifiedloginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo(IdentityHelper.XsrfKey, User.Identity.GetUserId());
                    if (verifiedloginInfo == null)
                    {
                        RedirectOnFail();
                        return;
                    }

                    var result = manager.AddLogin(User.Identity.GetUserId(), verifiedloginInfo.Login);
                    // todo in casa devi inserire email e password da sito esterno
                    if (result.Succeeded)
                    {
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                    else
                    {
                        AddErrors(result);
                        return;
                    }
                }
                else
                {
                    // todo in caso devi solo inserire l'email di fb
                    // trovare\ aggiungere username
                    TextUserName.Text = loginInfo.DefaultUserName;
                    
                }
            }
        }


        protected void CreateUser_Click(object sender, EventArgs e)
        {
            CreateAndLoginUser();
        }

        protected void checkAssociated_CheckedChanged(object sender, EventArgs e)
        {
            if (checkAssociated.Checked)
            {
                CFValidator.Enabled = true;
                FiscalCodeToValidate.Enabled = true;
                lblCF.Text = "Codice Fiscale *";
            }
            else
            {
                CFValidator.Enabled = false;
                FiscalCodeToValidate.Enabled = false;
                lblCF.Text = "Codice Fiscale";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        private void CreateAndLoginUser()
        {
            if (!IsValid)
            {
                return;
            }
            var db = new UserOperationsContext();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser()
            {
                UserName = TextUserName.Text,
                FirstName = TextFirstName.Text,
                LastName = TextLastName.Text,
                Telephone = TextTelephone.Text,
                CellPhone = TextCellPhone.Text,
                CF = TextCF.Text == "" ? null : TextCF.Text,
                NeedsApproval = true,
                Email = Email.Text
            };
            var passwordValidator = new PasswordValidator();
            passwordValidator.RequiredLength = 6;
            manager.PasswordValidator = passwordValidator;
            IdentityResult result = manager.Create(user);
            if (result.Succeeded)
            {
                var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                if (loginInfo == null)
                {
                    RedirectOnFail();
                    return;
                }
                result = manager.AddLogin(user.Id, loginInfo.Login);
                if (result.Succeeded)
                {

                    db.UserDatas.Add(new UserData
                    {
                        UserName = user.UserName,
                        Email = user.Email,
                        FullName = user.FirstName + " " + user.LastName
                    });
                    db.SaveChanges();

                    if (checkAssociated.Checked)
                        manager.AddToRole(user.Id, "Socio");
                    else
                        manager.AddToRole(user.Id, "Utente");
                    db.UserDatas.Add(new UserData
                    {
                        UserName = user.UserName,
                        Email = user.Email,
                        FullName = user.FirstName + " " + user.LastName
                    });
                    db.SaveChanges();

                    AdminActions.ComposeMessage(manager, user.Id, "", "Registrazione");
                    //IdentityHelper.SignIn(manager, user, isPersistent: false);

                    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771

                    //IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);

                    string titleMessage = string.Format("Grazie {0} {1},", user.FirstName, user.LastName);
                    string message = string.Format("Abbiamo registrato la tua richiesta, una mail di conferma verrà mandata all'indirizzo {0}, una volta confermata da un Amministratore.", user.Email);
                    string url = string.Format("~/MessagePage.aspx?TitleMessage={0}&Message={1}", titleMessage, message);
                    Response.Redirect(url);
                    return;
                }
            }
            AddErrors(result);
        }

        private void AddErrors(IdentityResult result) 
        {
            foreach (var error in result.Errors) 
            {
                ModelState.AddModelError("", error);
            }
        }
    }
}