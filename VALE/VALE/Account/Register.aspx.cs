using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using VALE.Models;

namespace VALE.Account
{
    public partial class Register : Page
    {
        protected void Page_PreRender(object sender, EventArgs e)
        {
            Email.Text = "domenico.moreschini@gmail.com";
            TextFirstName.Text = "Domenico";
            TextLastName.Text = "Moreschini";
            TextAddress.Text = "Via Galvoni 35";
            TextCity.Text = "Castignano";
            TextProv.Text = "AP";
            TextCF.Text = "MRSDNC87P25H769L";
            Password.Text = "Pa$$word1";
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() 
            {
                UserName = Email.Text,
                FirstName = TextFirstName.Text,
                LastName = TextLastName.Text,
                Address = TextAddress.Text,
                City = TextCity.Text,
                Province = TextProv.Text,
                CF = TextCF.Text,
                NeedsApproval = checkAssociated.Checked,
                Email = Email.Text 
            };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                string userId = user.Id;
                db.UsersData.Add(new UserData 
                { 
                    UserDataId = userId,
                    Email = user.Email,
                    FullName = user.FirstName + " " + user.LastName
                });
                db.SaveChanges();
                IdentityHelper.SignIn(manager, user, isPersistent: false);

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                //string code = manager.GenerateEmailConfirmationToken(user.Id);
                //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id);
                //manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");

                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}