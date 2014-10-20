using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;
using VALE.StateInfo;
using System.Web.Security;


namespace VALE.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        private string _currentUserName;
        private ApplicationUser _currentUser;
        private ApplicationDbContext _db;
        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new ApplicationDbContext();
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (Request.QueryString["Username"] != null)
                {
                    _currentUserName = Request.QueryString.GetValues("Username").First();
                }
                else
                {
                    _currentUserName = HttpContext.Current.User.Identity.Name;
                }
                _currentUser = _db.Users.Where(u => u.UserName == _currentUserName).FirstOrDefault();
                if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione")
                || _currentUserName == HttpContext.Current.User.Identity.Name
                || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Membro del consiglio"))
                    SetModifyMode();
                else
                    SetReadOnlyMode();
                UpdateView();
            }
            else 
            {
                Response.Redirect("~/Default");
            }
            
        }

        private void UpdateView() 
        {
            UpdatePerspnalInfo();
            UpdateImage();
            UpdateDescription();
        }

        private void UpdateDescription()
        {
            if (string.IsNullOrEmpty(_currentUser.Description))
                lblDescription.Text = "Nessuna Presentazione";
            else
            lblDescription.Text = _currentUser.Description;
        }

        private void UpdatePerspnalInfo()
        {
            LabelAddress.Text = "";
            LabelFullName.Text = _currentUser.UserName;
            LabelFirstName.Text = _currentUser.FirstName;
            LabelLastName.Text = _currentUser.LastName;
            if (!string.IsNullOrEmpty(_currentUser.CF))
            {
                LabelCF.Visible = true;
                lblLabelCF.Visible = true;
                LabelCF.Text = _currentUser.CF;
            }
            LabelEmail.Text = _currentUser.Email;
            if (!string.IsNullOrEmpty(_currentUser.Telephone))
            {
                LabelTelephone.Visible = true;
                lblLabelTelephone.Visible = true;
                LabelTelephone.Text = _currentUser.Telephone;
            }
            LabelCellPhone.Text = _currentUser.CellPhone;
            if (!string.IsNullOrEmpty(_currentUser.Address))
            {
                LabelAddress.Visible = true;
                lblLabelAddress.Visible = true;
                LabelAddress.Text = ", " + _currentUser.Address;
            }
            if (!string.IsNullOrEmpty(_currentUser.City))
            {
                LabelAddress.Visible = true;
                lblLabelAddress.Visible = true;
                LabelAddress.Text += ", " + _currentUser.City;
            }
            if (!string.IsNullOrEmpty(_currentUser.Province))
            {
                LabelAddress.Visible = true;
                lblLabelAddress.Visible = true;
                LabelAddress.Text += ", " + _currentUser.Province;
            }
            if (!string.IsNullOrEmpty(_currentUser.Region))
            {
                LabelAddress.Visible = true;
                lblLabelAddress.Visible = true;
                LabelAddress.Text += ", " + _currentUser.Region;
            }
            if (LabelAddress.Text != "")
            {
                LabelAddress.Text = LabelAddress.Text.Substring(1);
            }
            LabelRole.Text = GetRole(_currentUser.Id);
            LabelPartner.Text = _currentUser.IsPartner ? "Si" : "No";
            if (_currentUser.IsPartner)
            {
                LabelPartnerType.Visible = true;
                lblLabelPartnerType.Visible = true;
                LabelPartnerType.Text += " " + _currentUser.PartnerType;
            }
        }

        private void UpdateImage()
        {
            if (_currentUser.PhotoProfile != null)
            {
                picProfile.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(_currentUser.PhotoProfile);
                btnAddImage.Visible = false;
                btnEditImage.Visible = true;
                btnDeleteImage.Visible = true;
            }
            else 
            {
                picProfile.ImageUrl = "~/default_profile.jpg";
                btnAddImage.Visible = true;
                btnEditImage.Visible = false;
                btnDeleteImage.Visible = false;
            }
        }



        public string GetRole(string userId)
        {
            using (var actions = new UserActions())
            {
                return actions.GetRole(userId);
            }
        }

      
        protected void ImageButton_Click(object sender, ImageClickEventArgs e)
        {
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione")
                || _currentUserName == HttpContext.Current.User.Identity.Name
                || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Membro del consiglio"))
                pnlEditImageButtons.Visible = !pnlEditImageButtons.Visible;
        }

        public IQueryable<VALE.Models.UserFile> DocumentsGridView_GetData()
        {
            UserOperationsContext db = new UserOperationsContext();
            if(RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione")
                || _currentUserName == HttpContext.Current.User.Identity.Name
                || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Membro del consiglio"))
                return db.UserFiles.Where(f => f.UserName == _currentUserName).OrderBy(f => f.UserFileID);
            else
                return db.UserFiles.Where(f => f.UserName == _currentUserName && f.IsPublic).OrderBy(f => f.UserFileID);
        }

        protected void DocumentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            UserOperationsContext db = new UserOperationsContext();
            int id = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "DOWNLOAD":
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id + "&page=Profile");
                    break;
                case "Cancella":
                    var file = db.UserFiles.Where(f => f.UserFileID == id).FirstOrDefault();
                    db.UserFiles.Remove(file);
                    db.SaveChanges();
                    DocumentsGridView.PageIndex = 0;
                    DocumentsGridView.DataBind();
                    break;
                case "Page":
                    break;
            }
        }

        protected void btnAddDocument_Click(object sender, EventArgs e)
        {
            ModalPopupAddDocument.Show();
            LabelPopUpAddDocumentError.Visible = false;
            txtFileDescription.Text = "";
        }

        protected void btnAddImage_Click(object sender, EventArgs e)
        {
            ModalPopupAddImage.Show();
        }

        protected void btnEditImage_Click(object sender, EventArgs e)
        {
            ModalPopupAddImage.Show();
        }

        protected void btnDeleteImage_Click(object sender, EventArgs e)
        {
            _currentUser.PhotoProfile = null;
            _db.SaveChanges();
            UpdateImage();
        }

        protected void btnPopUpAddImage_Click(object sender, EventArgs e)
        {
            if (FileUploadAddImage.HasFile) 
            {
                var extensions = new List<string> { ".JPG", ".PNG", ".JPEG", ".BMP", ".JPE" };
                var extension = Path.GetExtension(FileUploadAddImage.PostedFile.FileName).ToUpper();
                if (extensions.Contains(extension)) 
                {
                    _currentUser.PhotoProfile = FileUploadAddImage.FileBytes;
                    _db.SaveChanges();
                    UpdateImage();
                }
            }
            
        }

        protected void btnPopUpAddImageClose_Click(object sender, EventArgs e)
        {
            ModalPopupAddImage.Hide();
        }

        protected void btnPopUpModifyDescriptionClose_Click(object sender, EventArgs e)
        {
            ModalPopupModifyDescription.Hide();
        }

        protected void btnPopUpModifyDescription_Click(object sender, EventArgs e)
        {
            _currentUser.Description = txtDescription.Text;
            _db.SaveChanges();
            UpdateDescription();
            pnlInfo.Visible = true;
            lblInfo.Text = "La Presentazione è stata aggiornata con successo.";
        }

        protected void btnModifyDescription_Click(object sender, EventArgs e)
        {
            txtDescription.Text = _currentUser.Description;
            ModalPopupModifyDescription.Show();
            
        }

        protected void btnPopUpAddDocument_Click(object sender, EventArgs e)
        {
            if (FileUploadAddDocument.HasFile)
            {
                UserOperationsContext db = new UserOperationsContext();
                UserFile file = new UserFile();
                var fileName = FileUploadAddDocument.PostedFile.FileName.Split(new char[] { '/', '\\' });
                file.FileName = fileName[fileName.Length - 1];
                file.FileDescription = txtFileDescription.Text;
                file.FileExtension = Path.GetExtension(FileUploadAddDocument.PostedFile.FileName);
                file.UserName = HttpContext.Current.User.Identity.Name;
                file.IsPublic = chkPublic.Checked;
                file.FileData = FileUploadAddDocument.FileBytes;
                db.UserFiles.Add(file);
                db.SaveChanges();
                DocumentsGridView.DataBind();
                pnlInfo.Visible = true;
                lblInfo.Text = "Il File è Stato aggiunto con successo.";
            }
            else
            {
                LabelPopUpAddDocumentError.Visible = true;
                LabelPopUpAddDocumentError.Text = "Il file deve essere scelto prima di premere OK";
                ModalPopupAddDocument.Show();
            }
        }

        protected void btnPopUpAddDocumentClose_Click(object sender, EventArgs e)
        {
            ModalPopupModifyDescription.Hide();
        }

        private void SetReadOnlyMode() 
        {

            DocumentsGridView.Columns[2].Visible = false;
            btnModifyPersonalData.Visible = false;
            btnModifyPassword.Visible = false;
            btnModifyDescription.Visible = false;
            btnAddDocument.Visible = false;
            lblLabelRole.Visible = false;
            LabelRole.Visible = false;
        }

        private void SetModifyMode()
        {
            DocumentsGridView.Columns[2].Visible = true;
            btnModifyPersonalData.Visible = true;
            btnModifyPassword.Visible = true;
            btnModifyDescription.Visible = true;
            btnAddDocument.Visible = true;
            lblLabelRole.Visible = true;
            LabelRole.Visible = true;
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione")
                || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Membro del consiglio"))
                pnlPartner.Visible = true;
            else
                pnlPartner.Visible = false;
        }

        protected void btnModifyPassword_Click(object sender, EventArgs e)
        {
            string userName = HttpContext.Current.User.Identity.Name;
            if ((RoleActions.checkPermission(userName, "Amministrazione") || RoleActions.checkPermission(userName, "Membro del consiglio")) && _currentUserName != userName)
            {
                pnlPasswordFild.Visible = false;
                passwordValidator.Enabled = false;
            }
             
            ModalPopupChangePassword.Show();
        }

        protected void btnModifyPersonalData_Click(object sender, EventArgs e)
        {
            SetRegionDropDownList();
            PopulateFormForModifyPersonalData();
            ModalPopupModifyPersonalData.Show();
        }

        protected void btnPopUpModifyPassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

                var passwordValidator = new PasswordValidator();
                //per la password sono richiesti solo sei caratteri
                passwordValidator.RequiredLength = 6;
                manager.PasswordValidator = passwordValidator;
                IdentityResult result;
                string userName = HttpContext.Current.User.Identity.Name;
                if ((RoleActions.checkPermission(userName, "Amministrazione") || RoleActions.checkPermission(userName, "Membro del consiglio")) && _currentUserName != userName)
                {

                    ApplicationUser user = manager.FindById(_currentUser.Id);

                    //PasswordHash is just a string. You can set to any string value, and it won't cause an error.
                    //It will just be challenging for the user to actually login.
                    user.PasswordHash = manager.PasswordHasher.HashPassword(NewPassword.Text.Trim());

                    //see below
                    manager.UpdateSecurityStamp(_currentUser.Id);
                    //save changes
                    result = manager.Update(user);
                    pnlInfo.Visible = true;
                    if (result.Succeeded)
                    {
                        lblInfo.Text = "La Password è stata cambiata con successo.";
                    }
                    else
                    {
                        string errors = "";
                        foreach (var error in result.Errors)
                        {
                            errors += error + "<br />";
                        }
                        lblChangePasswordError.Visible = true;
                        lblChangePasswordError.Text = errors;
                        ModalPopupChangePassword.Show();
                    }

                }
                else
                {
                    result = manager.ChangePassword(_currentUser.Id, CurrentPassword.Text, NewPassword.Text);
                    if (result.Succeeded)
                    {
                        var user = manager.FindById(User.Identity.GetUserId());
                        IdentityHelper.SignIn(manager, user, isPersistent: false);
                        pnlInfo.Visible = true;
                        lblInfo.Text = "La Password è stata cambiata con successo.";
                    }
                    else
                    {
                        string errors = "";
                        foreach (var error in result.Errors)
                        {
                            errors += error + "<br />";
                        }
                        lblChangePasswordError.Visible = true;
                        lblChangePasswordError.Text = errors;
                        ModalPopupChangePassword.Show();
                    }
                }
            }
        }

        protected void btnPopUpModifyPasswordClose_Click(object sender, EventArgs e)
        {
            ModalPopupChangePassword.Hide();
        }


        protected void btnClosePanelInfo_Click(object sender, EventArgs e)
        {
            pnlInfo.Visible = false;
        }

        protected void btnPopupModifyPersonalDataClose_Click(object sender, EventArgs e)
        {
            ModalPopupModifyPersonalData.Hide();
        }

        protected void btnPopupModifyPersonalData_Click(object sender, EventArgs e)
        {
            _currentUser.FirstName = TextFirstName.Text;
            _currentUser.LastName = TextLastName.Text;
            _currentUser.Email = Email.Text;
            _currentUser.CellPhone = TextCellPhone.Text;
            _currentUser.CF = TextCF.Text;
            _currentUser.Telephone = TextTelephone.Text;
            _currentUser.Address = TextAddress.Text;
            if (Region.SelectedIndex != 0)
                _currentUser.Region = Region.SelectedValue;
            else
                _currentUser.Region = "";
            if (Province.SelectedIndex != 0)
                _currentUser.Province = Province.SelectedValue;
            else
                _currentUser.Province = "";
            if (City.SelectedIndex != 0)
                _currentUser.City = City.SelectedValue;
            else
                _currentUser.City = "";
            _currentUser.IsPartner = checkAssociated.Checked;
            _currentUser.PartnerType = ddlPartnerType.SelectedValue;
            _db.SaveChanges();
            ModalPopupModifyPersonalData.Hide();
            Response.Redirect("/Account/Profile?Username=" + _currentUserName);
        }

        private void ClearDropDownList()
        {
            List<string> init = new List<string> { "Seleziona" };
            Province.DataSource = init;
            Province.DataBind();
            City.DataSource = init;
            City.DataBind();
        }

        private void SetRegionDropDownList()
        {
            ClearDropDownList();
            String path = Server.MapPath("~/StateInfo/regioni_province_comuni.xml");
            StateInfoXML.GetInstance().FileName = path;
            var list = StateInfoXML.GetInstance().LoadData();
            var regions = (from r in list where r.depth == "0" orderby r.name select r.name).ToList();
            regions.Insert(0, "Seleziona");
            Region.DataSource = regions;
            Region.DataBind();
        }

        protected void Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Region.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                Province.DataSource = init;
                Province.DataBind();
                City.DataSource = init;
                City.DataBind();
            }
            else
            {
                ClearDropDownList();
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "0" && r.name == Region.SelectedValue select r.tid).FirstOrDefault();
                var provinces = (from r in list where r.depth == "1" && r.parent == tid orderby r.name select r.name).ToList();
                provinces.Insert(0, "Seleziona");
                Province.DataSource = provinces;
                Province.DataBind();
                Province.Focus();
            }
            ModalPopupModifyPersonalData.Show();
        }

        private void InitialiseValueForDropDownList()
        {
            if (!string.IsNullOrEmpty(_currentUser.Region))
            {
                Region.SelectedValue = _currentUser.Region;
                Region_SelectedIndexChanged(this, EventArgs.Empty);
            }
            if (!string.IsNullOrEmpty(_currentUser.Province))
            {
                Province.SelectedValue = _currentUser.Province;
                Province_SelectedIndexChanged(this, EventArgs.Empty);
            }
            if (!string.IsNullOrEmpty(_currentUser.City))
                City.SelectedValue = _currentUser.City;
        }

        protected void Province_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Province.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                City.DataSource = init;
                City.DataBind();
            }
            else
            {
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "1" && r.name == Province.SelectedValue select r.tid).FirstOrDefault();
                var citys = (from r in list where r.depth == "2" && r.parent == tid orderby r.name select r.name).ToList();
                citys.Insert(0, "Seleziona");
                City.DataSource = citys;
                City.DataBind();
                City.Focus();
            }
            ModalPopupModifyPersonalData.Show();
        }

        private void PopulateFormForModifyPersonalData()
        {
            TextFirstName.Text = _currentUser.FirstName;
            TextLastName.Text = _currentUser.LastName;
            TextCF.Text = _currentUser.CF;
            Email.Text = _currentUser.Email;
            TextCellPhone.Text = _currentUser.CellPhone;
            TextTelephone.Text = _currentUser.Telephone;
            TextAddress.Text = _currentUser.Address;
            InitialiseValueForDropDownList();
            if (_currentUser.IsPartner)
            {
                checkAssociated.Checked = true;
                pnlPartnerType.Visible = true;
            }
            else 
            {
                checkAssociated.Checked = false;
                pnlPartnerType.Visible = false;
            }
            if (!string.IsNullOrEmpty(_currentUser.PartnerType))
                ddlPartnerType.SelectedValue = _currentUser.PartnerType;
        }

        protected void checkAssociated_CheckedChanged(object sender, EventArgs e)
        {
            if (checkAssociated.Checked)
            {
                pnlPartnerType.Visible = true;
                pnlPartnerType.Focus();
            }

            else 
            {
                pnlPartnerType.Visible = false;
                checkAssociated.Focus();
            }
            ModalPopupModifyPersonalData.Show();
        }

        public List<PartnerType> ddlPartnerType_GetData()
        {
            var db = new UserOperationsContext();
            return db.PartnerTypes.ToList();
        }
    }
}