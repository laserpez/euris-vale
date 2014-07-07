using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using VALE.Models;
using VALE.Logic;
using System.IO;

namespace VALE
{
    public partial class MenageProfile : System.Web.UI.Page
    {
        private string _currentUser = HttpContext.Current.User.Identity.Name;
        private ApplicationDbContext db = new ApplicationDbContext();

        protected bool CanRemoveExternalLogins
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                byte [] imagebytes = null;
                ViewState["imageBytes"] = imagebytes;

                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                CanRemoveExternalLogins = manager.GetLogins(User.Identity.GetUserId()).Count() > 1;

                SetAssociationStatus();
                SetImage();
                SetCV();
            }
        }

        private void SetCV()
        {
            var user = db.Users.Where(u => u.UserName == _currentUser).FirstOrDefault();
            if (user.Document == null)
                CVEdit.Text = "CV: nessun CV attualmente caricato";
            else
                CVEdit.Text = "CV: " + user.CVName;
        }

        private void SetImage()
        {
            var db = new ApplicationDbContext();
            var imageBytes = db.Users.Where(u => u.UserName == _currentUser).Select(us => us.PhotoProfile).FirstOrDefault();
            if (imageBytes != null)
                picProfile.Src = "data:image/png;base64," + Convert.ToBase64String(imageBytes);
            else
                picProfile.Src = "~/Images/User.jpg";
        }

        public ApplicationUser GetUserData()
        {
            var db = new ApplicationDbContext();
            return db.Users.FirstOrDefault(u => u.UserName == _currentUser);
        }

        public string GetRole(string userId)
        {
            using (var actions = new UserActions())
            {
                return actions.GetRole(userId);
            }
        }

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            if (FileUploadPhoto.HasFile)
            {
                picProfile.Src = "data:image/png;base64," + Convert.ToBase64String(FileUploadPhoto.FileBytes);
                ViewState["imageBytes"] = FileUploadPhoto.FileBytes;
            }
        }

        protected void SaveChangesProfile_Click(object sender, EventArgs e)
        {
            var Email = (TextBox)PersonalDataFormView.FindControl("EditEmail");
            var Telephone = (TextBox)PersonalDataFormView.FindControl("EditTelephone");
            var CellPhone = (TextBox)PersonalDataFormView.FindControl("EditCellPhone");
            var Address = (TextBox)PersonalDataFormView.FindControl("EditAdress");
            var Region = (TextBox)PersonalDataFormView.FindControl("EditRegion");
            var Province = (TextBox)PersonalDataFormView.FindControl("EditProvince");
            var City = (TextBox)PersonalDataFormView.FindControl("EditCity");
            var Description = (TextBox)PersonalDataFormView.FindControl("EditDescription");

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            var passwordValidator = new PasswordValidator();
            passwordValidator.RequiredLength = 6;
            manager.PasswordValidator = passwordValidator;

            IdentityResult result = manager.ChangePassword(User.Identity.GetUserId(), CurrentPassword.Text, NewPassword.Text);
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                if (ViewState["imageBytes"] != null)
                    user.PhotoProfile = (byte[])ViewState["imageBytes"];
                user.Email = Email.Text;
                user.Telephone = Telephone.Text;
                user.CellPhone = CellPhone.Text;
                user.Address = Address.Text;
                user.Region = Region.Text;
                user.Province = Province.Text;
                user.City = City.Text;
                user.Description = Description.Text;

                db.SaveChanges();
            }
            ViewState["imageBytes"] = null;
            Response.Redirect("~/Account/Profile");
        }

        protected void RemovePhoto_Click(object sender, EventArgs e)
        {
            SetImage();
        }

        protected void AddCVButton_Click(object sender, EventArgs e)
        {
            var db = new ApplicationDbContext();
            var user = db.Users.FirstOrDefault(u => u.UserName == _currentUser);
            if (FileUploadDocument.HasFile)
            {
                if (user != null)
                {
                    user.CVName = FileUploadDocument.FileName;
                    user.Document = FileUploadDocument.FileBytes;
                    db.SaveChanges();
                }
            }

            SetCV();
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
            Response.Redirect("~/Account/MenageProfile");
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        public IEnumerable<UserLoginInfo> GetLogins()
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var accounts = manager.GetLogins(User.Identity.GetUserId());
            CanRemoveExternalLogins = accounts.Count() > 1 || HasPassword(manager);
            return accounts;
        }

        private void SetAssociationStatus()
        {
            string userId = User.Identity.GetUserId();
            var db = new ApplicationDbContext();
            if (User.IsInRole("Socio"))
            {
                btnRequestAssociation.Enabled = false;
                btnRequestAssociation.CssClass = "btn btn-success disabled btn-xs";
                btnRequestAssociation.Text = "Sei già associato";
            }
            else
            {
                if (db.Users.First(u => u.Id == userId).NeedsApproval)
                {
                    btnRequestAssociation.Enabled = false;
                    btnRequestAssociation.CssClass = "btn btn-warning disabled btn-xs";
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
            SetAssociationStatus();
        }
    }
}