using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using VALE.Models;

namespace VALE.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        protected bool CanRemoveExternalLogins
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        protected void Page_Load()
        {
            if (!IsPostBack)
            {
                // Determine the sections to render
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                if (HasPassword(manager))
                {
                    changePasswordHolder.Visible = true;
                }
                else
                {
                    setPassword.Visible = true;
                    changePasswordHolder.Visible = false;
                }
                CanRemoveExternalLogins = manager.GetLogins(User.Identity.GetUserId()).Count() > 1;

                // Render success message
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Strip the query string from action
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "La tua password è stata modificata."
                        : message == "SetPwdSuccess" ? "La tua password è stata settata."
                        : message == "RemoveLoginSuccess" ? "L'account è stato rimosso."
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
                SetAssociationStatus();
            }
        }

        protected void ChangePassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

                var passwordValidator = new PasswordValidator();
                //per la password sono richiesti solo sei caratteri
                passwordValidator.RequiredLength = 6;
                manager.PasswordValidator = passwordValidator;

                IdentityResult result = manager.ChangePassword(User.Identity.GetUserId(), CurrentPassword.Text, NewPassword.Text);
                if (result.Succeeded)
                {
                    var user = manager.FindById(User.Identity.GetUserId());
                    IdentityHelper.SignIn(manager, user, isPersistent: false);
                    Response.Redirect("~/Account/Manage?m=ChangePwdSuccess");
                }
                else
                {
                    AddErrors(result);
                }
            }
        }

        protected void SetPassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Create the local login info and link the local account to the user
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                IdentityResult result = manager.AddPassword(User.Identity.GetUserId(), password.Text);
                if (result.Succeeded)
                {
                    Response.Redirect("~/Account/Manage?m=SetPwdSuccess");
                }
                else
                {
                    AddErrors(result);
                }
            }
        }

        public IEnumerable<UserLoginInfo> GetLogins()
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var accounts = manager.GetLogins(User.Identity.GetUserId());
            CanRemoveExternalLogins = accounts.Count() > 1 || HasPassword(manager);
            return accounts;
        }

        public void RemoveLogin(string loginProvider, string providerKey)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var result = manager.RemoveLogin(User.Identity.GetUserId(), new UserLoginInfo(loginProvider, providerKey));
            string msg = String.Empty;
            if (result.Succeeded)
            {
                var user = manager.FindById(User.Identity.GetUserId());
                IdentityHelper.SignIn(manager, user, isPersistent: false);
                msg = "?m=RemoveLoginSuccess";
            }
            Response.Redirect("~/Account/Manage" + msg);
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private void SetAssociationStatus()
        {
            string userId = User.Identity.GetUserId();
            var db = new ApplicationDbContext();
            if (User.IsInRole("AssociatedUser"))
            {
                btnRequestAssociation.Enabled = false;
                btnRequestAssociation.CssClass = "btn btn-success disabled";
                btnRequestAssociation.Text = "Sei già associato";
            }
            else
            {
                if(db.Users.First(u => u.Id == userId).NeedsApproval)
                {
                    btnRequestAssociation.Enabled = false;
                    btnRequestAssociation.CssClass = "btn btn-warning disabled";
                    btnRequestAssociation.Text = "Approvazione sospesa";
                }
                else
                {
                    btnRequestAssociation.CssClass = "btn btn-info";
                    btnRequestAssociation.Text = "Associazione richiesta";
                }
            }
        }

        protected void btnRequestAssociation_Click(object sender, EventArgs e)
        {
            string userId = User.Identity.GetUserId();
            var db = new ApplicationDbContext();
            db.Users.First(u => u.Id == userId).NeedsApproval = true;
            db.SaveChanges();
            lblRequestAssociation.Text = "Richiesta inviata";
            SetAssociationStatus();
        }
    }
}