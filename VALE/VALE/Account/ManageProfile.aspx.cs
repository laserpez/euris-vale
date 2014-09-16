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
using VALE.StateInfo;

namespace VALE
{
    public partial class ManageProfile : System.Web.UI.Page
    {
        private string _currentUser = HttpContext.Current.User.Identity.Name;
        private ApplicationDbContext db = new ApplicationDbContext();
        private UserOperationsContext dbData = new UserOperationsContext();

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

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                byte [] imagebytes = null;
                ViewState["imageBytes"] = imagebytes;

                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                CanRemoveExternalLogins = manager.GetLogins(User.Identity.GetUserId()).Count() > 1;

                SetRegionDropDownList();
                SetInitialValueForDropDownList();
                SetAssociationStatus();
                SetImage();
                SetCV();
            }
        }

        protected void Page_PreRender(EventArgs e)
        {
            var message = Request.QueryString["m"];
            if (message != null)
            {
                // Strip the query string from action
                Form.Action = ResolveUrl("~/Account/Manage");

                SuccessMessage =
                    message == "ChangePwdSuccess" ? "La tua password è stata modificata."
                    : message == "RemoveLoginSuccess" ? "L'account è stato rimosso."
                    : String.Empty;
                successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
            }
        }

        private void SetCV()
        {
            var user = dbData.UserDatas.Where(u => u.UserName == _currentUser).FirstOrDefault();
            if (user.Files != null) 
            {
                var files = dbData.UserFiles.Where(f => f.UserName == user.UserName);
                CVEdit.Text = "Cisono " + files.Count() + " Files";
            }
                
            //    CVEdit.Text = "CV: nessun CV attualmente caricato";
            //else
            //    CVEdit.Text = "CV: " + user.CVName;
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
            return db.Users.FirstOrDefault(u => u.UserName == _currentUser);
        }

        public string GetRole(string userId)
        {
            using (var actions = new UserActions())
            {
                return actions.GetRole(userId);
            }
        }

        private void SetInitialValueForDropDownList()
        {
            var DropDownRegion = (DropDownList)PersonalDataFormView.FindControl("DropDownRegion");
            var DropDownProvince = (DropDownList)PersonalDataFormView.FindControl("DropDownProvince");
            var DropDownCity = (DropDownList)PersonalDataFormView.FindControl("DropDownCity");

            var user = db.Users.FirstOrDefault(u => u.UserName == _currentUser);
            if (user.Region != null)
            {
                DropDownRegion.SelectedValue = user.Region;
                Region_SelectedIndexChanged(this, EventArgs.Empty);
            }
            if (user.Province != null)
            {
                DropDownProvince.SelectedValue = user.Province;
                State_SelectedIndexChanged(this, EventArgs.Empty);
            }
            if (user.City != null)
                DropDownCity.SelectedValue = user.City;
        }

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            if (FileUploadPhoto.HasFile)
            {
                picProfile.Src = "data:image/png;base64," + Convert.ToBase64String(FileUploadPhoto.FileBytes);
                ViewState["imageBytes"] = FileUploadPhoto.FileBytes;
            }
        }

        private void ClearDropDownList()
        {
            var DropDownProvince = (DropDownList)PersonalDataFormView.FindControl("DropDownProvince");
            var DropDownCity = (DropDownList)PersonalDataFormView.FindControl("DropDownCity");

            List<string> init = new List<string> { "Seleziona" };
            DropDownProvince.DataSource = init;
            DropDownProvince.DataBind();
            DropDownCity.DataSource = init;
            DropDownCity.DataBind();
        }

        private void SetRegionDropDownList()
        {
            var DropDownRegion = (DropDownList)PersonalDataFormView.FindControl("DropDownRegion");

            ClearDropDownList();
            String path = Server.MapPath("~/StateInfo/regioni_province_comuni.xml");
            StateInfoXML.GetInstance().FileName = path;
            var list = StateInfoXML.GetInstance().LoadData();
            var regions = (from r in list where r.depth == "0" orderby r.name select r.name).ToList();
            regions.Insert(0, "Seleziona");
            DropDownRegion.DataSource = regions;
            DropDownRegion.DataBind();

            
        }

        protected void Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            var DropDownRegion = (DropDownList)PersonalDataFormView.FindControl("DropDownRegion");
            var DropDownProvince = (DropDownList)PersonalDataFormView.FindControl("DropDownProvince");
            var DropDownCity = (DropDownList)PersonalDataFormView.FindControl("DropDownCity");

            if (DropDownRegion.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                DropDownProvince.DataSource = init;
                DropDownProvince.DataBind();
                DropDownCity.DataSource = init;
                DropDownCity.DataBind();
            }
            else
            {
                ClearDropDownList();

                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "0" && r.name == DropDownRegion.SelectedValue select r.tid).FirstOrDefault();
                var provinces = (from r in list where r.depth == "1" && r.parent == tid orderby r.name select r.name).ToList();
                provinces.Insert(0, "Seleziona");
                DropDownProvince.DataSource = provinces;
                DropDownProvince.DataBind();
            }
        }

        protected void State_SelectedIndexChanged(object sender, EventArgs e)
        {
            var DropDownProvince = (DropDownList)PersonalDataFormView.FindControl("DropDownProvince");
            var DropDownCity = (DropDownList)PersonalDataFormView.FindControl("DropDownCity");

            if (DropDownProvince.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                DropDownCity.DataSource = init;
                DropDownCity.DataBind();
            }
            else
            {
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "1" && r.name == DropDownProvince.SelectedValue select r.tid).FirstOrDefault();
                var citys = (from r in list where r.depth == "2" && r.parent == tid orderby r.name select r.name).ToList();
                citys.Insert(0, "Seleziona");
                DropDownCity.DataSource = citys;
                DropDownCity.DataBind();
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
                    Response.Redirect("~/Account/ManageProfile?m=ChangePwdSuccess");
                }
                else
                {
                    AddErrors(result);
                }
            }
        }

        protected void SaveChangesProfile_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            var LabelEditError = (Label)PersonalDataFormView.FindControl("LabelEditError");
            var FirstName = (TextBox)PersonalDataFormView.FindControl("EditFirstName");
            var LastName = (TextBox)PersonalDataFormView.FindControl("EditLastName");
            var CF = (TextBox)PersonalDataFormView.FindControl("EditCF");
            var Email = (TextBox)PersonalDataFormView.FindControl("EditEmail");
            var Telephone = (TextBox)PersonalDataFormView.FindControl("EditTelephone");
            var CellPhone = (TextBox)PersonalDataFormView.FindControl("EditCellPhone");
            var Address = (TextBox)PersonalDataFormView.FindControl("EditAdress");
            var DropDownRegion = (DropDownList)PersonalDataFormView.FindControl("DropDownRegion");
            var DropDownProvince = (DropDownList)PersonalDataFormView.FindControl("DropDownProvince");
            var DropDownCity = (DropDownList)PersonalDataFormView.FindControl("DropDownCity");
            var Description = (TextBox)PersonalDataFormView.FindControl("EditDescription");

            var modifiedUser = db.Users.First(u => u.UserName == _currentUser);
            var modifiedUserData = dbData.UserDatas.FirstOrDefault(u => u.UserName == _currentUser);

            var oldEmail = modifiedUser.Email;

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser userWithOldEmail = manager.FindByEmail(Email.Text);
            if (userWithOldEmail != null && userWithOldEmail.UserName != _currentUser)
            {
                LabelEditError.Visible = true;
                LabelEditError.Text = "L'inidirizzo e-mail esiste già.";
            }
            else
            {
                LabelEditError.Visible = false;

                if (modifiedUser != null)
                {
                    if (ViewState["imageBytes"] != null)
                        modifiedUser.PhotoProfile = (byte[])ViewState["imageBytes"];
                    modifiedUser.FirstName = FirstName.Text;
                    modifiedUser.LastName = LastName.Text;
                    modifiedUser.CF = CF.Text;
                    modifiedUser.Email = Email.Text;
                    modifiedUser.Telephone = Telephone.Text;
                    modifiedUser.CellPhone = CellPhone.Text;
                    modifiedUser.Address = Address.Text;
                    modifiedUser.Region = DropDownRegion.Text;
                    modifiedUser.Province = DropDownProvince.Text;
                    modifiedUser.City = DropDownCity.Text;
                    modifiedUser.Description = Description.Text;

                    modifiedUserData.FullName = FirstName.Text + " " + LastName.Text;
                    modifiedUserData.Email = Email.Text;

                    db.SaveChanges();
                    dbData.SaveChanges();
                }

                if (oldEmail != Email.Text)
                {
                    var allMailUser = dbData.MailQueues.Where(m => m.mMail.To == oldEmail).ToList();
                    foreach (var mail in allMailUser)
                    {
                        mail.mMail.To = Email.Text;
                        var log = dbData.LogEntriesEmail.FirstOrDefault(m => m.MailQueueId == mail.MailQueueId);
                        log.Receiver = Email.Text;

                        dbData.SaveChanges();
                    }
                }

                ViewState["imageBytes"] = null;
                Response.Redirect("~/Account/Profile");
            }
        }

        protected void RemovePhoto_Click(object sender, EventArgs e)
        {
            SetImage();
        }

        protected void AddCVButton_Click(object sender, EventArgs e)
        {
            var db = new ApplicationDbContext();
            var user = dbData.UserDatas.Where(u => u.UserName == _currentUser).FirstOrDefault();
            if (FileUploadDocument.HasFile)
            {
                if (user != null)
                {
                    UserFile file = new UserFile();
                    file.FileData = FileUploadDocument.FileBytes;
                    file.FileName = FileUploadDocument.FileName;
                    file.UserName = user.UserName;
                    dbData.UserFiles.Add(file);
                    dbData.SaveChanges();
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
            Response.Redirect("~/Account/ManageProfile");
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
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name,"CreazioneProgetti"))
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
                    btnRequestAssociation.CssClass = "btn btn-info btn-xs";
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