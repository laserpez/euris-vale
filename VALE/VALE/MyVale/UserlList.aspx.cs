using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using VALE.StateInfo;
using System.Text.RegularExpressions;

namespace VALE.MyVale
{
    public partial class UserlList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var db = new ApplicationDbContext();
            //var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            //var user = db.Users.Where(o => o.UserName == HttpContext.Current.User.Identity.Name).Select(o => o.Id).FirstOrDefault();
            //manager.SendEmail(user, "Confirm your account", "Please confirm your account by clicking");
        }

        public IQueryable<ApplicationUser> GetUsers()
        {
            var db = new ApplicationDbContext();
            return db.Users;
        }
    }
}