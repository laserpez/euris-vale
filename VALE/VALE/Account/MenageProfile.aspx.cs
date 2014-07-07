using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using VALE.Logic;
using System.IO;

namespace VALE
{
    public partial class MenageProfile : System.Web.UI.Page
    {
        private string _currentUser = HttpContext.Current.User.Identity.Name;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                byte [] imagebytes = null;
                ViewState["imageBytes"] = imagebytes;
            }

            SetImage();
            SetCV();
        }

        private void SetCV()
        {

            var db = new ApplicationDbContext();
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
            //string _currentUser = HttpContext.Current.User.Identity.Name;
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

            var db = new ApplicationDbContext();
            var user = db.Users.FirstOrDefault(u => u.UserName == _currentUser);
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
    }
}