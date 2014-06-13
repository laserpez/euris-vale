using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class UserlList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<ApplicationUser> GetUsers()
        {
            var db = new ApplicationDbContext();
            return db.Users;
        }
    }
}