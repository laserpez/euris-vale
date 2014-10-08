using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using VALE.Models;
using System.Text.RegularExpressions;

namespace VALE.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register";
            // Enable this once you have account confirmation enabled for password reset functionality
            // ForgotPasswordHyperLink.NavigateUrl = "Forgot";
            OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                string pat = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}";
                string name = null;

                ApplicationUser user = null;
                user = manager.Find(UserName.Text, Password.Text);
                if (user == null)
                {
                    // Instantiate the regular expression object.
                    Regex r = new Regex(pat, RegexOptions.IgnoreCase);

                    // Match the regular expression pattern against a text string.
                    Match m = r.Match(UserName.Text);

                    //controllo del NULL
                    if (m.Success)
                    {
                        var utente = manager.FindByEmail(UserName.Text);
                        if (utente != null)
                            name = utente.UserName;
                        if (name != null)
                            user = manager.Find(name, Password.Text);
                    }
                }
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
                        IdentityHelper.SignIn(manager, user, RememberMe.Checked);
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                }
                else
                {
                    FailureText.Text = "Username o password non valide.";
                    ErrorMessage.Visible = true;
                }
            }
        }
    }
}
