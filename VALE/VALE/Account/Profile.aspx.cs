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
    public partial class Profile : System.Web.UI.Page
    {
        private string _currentUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = HttpContext.Current.User.Identity.Name;
            HeaderName.Text = "Profilo di " + _currentUser;

            if (!IsPostBack)
            {
                if (Request.QueryString["Username"] != null)
                {
                    var _currentUserName = Request.QueryString.GetValues("Username").First();
                    if (_currentUser != _currentUserName)
                        EditProfile.Visible = false;
                }
            }

            SetImage();
            SetCV();
        }

        private void SetCV()
        {
            var buttonAttachment = (LinkButton)PersonalDataFormView.FindControl("CVAttachment");

            var db = new ApplicationDbContext();
            var user = db.Users.Where(u => u.UserName == _currentUser).FirstOrDefault();
            if (user.Document== null)
            {
                buttonAttachment.Text = "Nessun CV attualmente caricato";
                buttonAttachment.Enabled = false;
            }
            else
            {
                buttonAttachment.Text = user.CVName;
            }
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

        protected void EditProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/ManageProfile?currentUser=" + _currentUser);
        }

        protected void CVAttachment_Click(object sender, EventArgs e)
        {
            var db = new ApplicationDbContext();
            var user = db.Users.Where(u => u.UserName == _currentUser).FirstOrDefault();
            if (user.Document != null)
            {
                HttpResponse response = HttpContext.Current.Response;
                response.ClearContent();
                response.Clear();
                response.ContentType = "Application/octet-stream";
                response.AddHeader("Content-Disposition", "attachment; filename=" + user.CVName + ";");
                response.BinaryWrite(user.Document);
                response.Flush();
                response.End();
            }
        }
    }
}