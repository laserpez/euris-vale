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
        protected void Page_Load(object sender, EventArgs e)
        {
            //string _currentUser = Request.QueryString["currentUser"].ToString();
        }

        public ApplicationUser GetUserData()
        {
            string _currentUser = HttpContext.Current.User.Identity.Name;
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
            string _currentUser = HttpContext.Current.User.Identity.Name;
            var db = new ApplicationDbContext();
            var user = db.Users.FirstOrDefault(u => u.UserName == _currentUser);
            if (FileUpload.HasFile)
            {
                if (user != null)
                {
                    user.PhotoProfile = FileUpload.FileBytes;
                    db.SaveChanges();
                }
            }
        }

        protected void SaveChangesProfile_Click(object sender, EventArgs e)
        {

        }

        protected void EditPhoto_Click(object sender, EventArgs e)
        {

        }

        protected void RemovePhoto_Click(object sender, EventArgs e)
        {

        }
    }
}