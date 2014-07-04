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

            //SetImage();
        }

        //private void SetImage()
        //{
        //    var db = new ApplicationDbContext();
        //    FileStream stream = new FileStream("test.png", FileMode.Open, FileAccess.Read);
        //    photoProfile. = Image.FromStream(stream);
        //    stream.Close();
        //}

        //public ActionResult showImg(int id)
        //{
        //    var db = new ApplicationDbContext();

        //    //var imageData = from m in db.Users
        //    //                select Image.FromStream(new MemoryStream(m.PhotoProfile.ToArray()));

        //    var stream = (from m in db.Users select m.PhotoProfile).FirstOrDefault();

        //    return Image(stream, "image/jpeg");
        //}

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
            Response.Redirect("~/Account/MenageProfile?currentUser=" + _currentUser);
        }
    }
}