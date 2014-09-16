using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using VALE.Models;
using System.Collections.Generic;
using VALE.StateInfo;
using System.Text.RegularExpressions;
using VALE.Logic;


namespace VALE.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string password = Password.Text;
            Password.Attributes.Add("value", password);
            string confirmPassword = ConfirmPassword.Text;
            ConfirmPassword.Attributes.Add("value", confirmPassword);
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

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser()
            {
                UserName = TextUserName.Text,
                FirstName = TextFirstName.Text,
                LastName = TextLastName.Text,
                Telephone = TextTelephone.Text,
                CellPhone = TextCellPhone.Text,
                PartnerType = "Generico",
                CF = TextCF.Text == "" ? null : TextCF.Text,
                NeedsApproval = true,
                IsPartner = checkAssociated.Checked,
                Email = Email.Text
            };
            var passwordValidator = new PasswordValidator();
            //per la password sono richiesti solo sei caratteri
            passwordValidator.RequiredLength = 6;
            manager.PasswordValidator = passwordValidator;

            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
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
            }
            else
            {
                ModelState.AddModelError("", result.Errors.FirstOrDefault());
            }
        }
    }
}