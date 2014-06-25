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
using System.Web.ModelBinding;

namespace VALE.MyVale
{
    public partial class UserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                filterPanel.Visible = false;
        }

        public IQueryable<ApplicationUser> GetUsers([Control]string txtName, [Control]string txtLastname, [Control]string txtUsername, [Control]string txtEmail)
        {
            var db = new ApplicationDbContext();
            var users = db.Users.AsQueryable();
            if (txtName != null)
                users = users.Where(u => u.FirstName.ToUpper().Contains(txtName));
            if(txtLastname != null)
                users = users.Where(u => u.LastName.ToUpper().Contains(txtLastname));
            if (txtUsername != null)
                users = users.Where(u => u.UserName.ToUpper().Contains(txtUsername));
            if (txtEmail != null)
                users = users.Where(u => u.Email.Contains(txtEmail));

            return users;
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            grdUsers.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtEmail.Text = null;
            txtLastname.Text = null;
            txtName.Text = null;
            txtUsername.Text = null;
            grdUsers.DataBind();
        }
    }
}