//using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var users = GetWaitingUsers();
            if (!IsPostBack)
            {
                var lstUsers = GetUsers();
                grdUsers.DataSource = lstUsers;
                grdUsers.DataBind();
                ViewState["lstProject"] = lstUsers;
                filterPanel.Visible = false;
            }
            if (users.Count() == 0)
                btnConfirmUser.Enabled = false;
            
        }

        public IQueryable<ApplicationUser> GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users.Where(u => u.NeedsApproval == true);
            return users;
        }

        public List<ApplicationUser> GetUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users.ToList();
            return users;
        }

        public string GetRoleName(string userId)
        {
            var db = new ApplicationDbContext();
            var user = db.Users.First(u => u.Id == userId);
            if (user.Roles.Count != 0)
            {
                var roleId = user.Roles.First().RoleId;
                var roleName = db.Roles.FirstOrDefault(o => o.Id == roleId).Name;
                return roleName;
            }
            else
                return "Utente";
        }

        protected void btnConfimUser_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < grdWaitingUsers.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)grdWaitingUsers.Rows[i].FindControl("chkSelectUser");
                if (chkBox.Checked)
                {
                    string userName = grdWaitingUsers.Rows[i].Cells[0].Text;
                    AdminActions.ConfirmUser(userName);
                    string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                    Response.Redirect(pageUrl);
                    //MailHelper.SendMail(WaitingUsers.Rows[i].Cells[1].Text, "Your associated account has been confirmed", "Account confirmed");
                }
            }
            grdWaitingUsers.DataBind();
            grdUsers.DataBind();
        }

        protected void btnChangeUser_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            if (button.Text == "Amministratore")
            {
                lblChangeRole.Text = UserActions.ChangeUserRole(button.CommandArgument, "Amministratore");
                if (lblChangeRole.Text != "")
                    lblChangeRole.Visible = true;
            }
            else if (button.Text == "Membro del consiglio")
            {
                lblChangeRole.Text = UserActions.ChangeUserRole(button.CommandArgument, "Membro del consiglio");
                if (lblChangeRole.Text != "")
                    lblChangeRole.Visible = true;
            }
            else if (button.Text == "Socio")
            {
                lblChangeRole.Text = UserActions.ChangeUserRole(button.CommandArgument, "Socio");
                if (lblChangeRole.Text != "")
                    lblChangeRole.Visible = true;
            }
            grdUsers.DataBind();
        }
        protected void UsersList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;

            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            grdUsers.DataSource = GetSortedData(e.SortExpression);
            grdUsers.DataBind();
        }

        private List<ApplicationUser> GetSortedData(string sortExpression)
        {
            var result = (List<ApplicationUser>)ViewState["lstProject"];

            var param = Expression.Parameter(typeof(ApplicationUser), sortExpression);
            var sortBy = Expression.Lambda<Func<ApplicationUser, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                result = result.AsQueryable<ApplicationUser>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<ApplicationUser>().OrderBy(sortBy).ToList();
            ViewState["lstProject"] = result;
            return result;
        }

        public SortDirection GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] == null)
                    ViewState["sortDirection"] = SortDirection.Ascending;

                return (SortDirection)ViewState["sortDirection"];
            }
            set { ViewState["sortDirection"] = value; }
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            ViewState["lstProject"] = GetUsers();
            if (!String.IsNullOrEmpty(txtName.Text))
                FilterByName(txtName.Text);
            if (!String.IsNullOrEmpty(txtLastname.Text))
                FilterByLastname(txtLastname.Text);
            if (!String.IsNullOrEmpty(txtUsername.Text))
                FilterByUsername(txtUsername.Text);
            if (!String.IsNullOrEmpty(txtEmail.Text))
                FilterByLastModifiedDate(txtEmail.Text);
            var result = (List<ApplicationUser>)ViewState["lstProject"];
            grdUsers.DataSource = result;
            grdUsers.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtLastname.Text = "";
            txtUsername.Text = "";
            txtEmail.Text = "";
            var result = GetUsers();
            ViewState["lstProject"] = result;
            grdUsers.DataSource = result;
            grdUsers.DataBind();

        }
        private void FilterByName(string name)
        {
            var result = (List<ApplicationUser>)ViewState["lstProject"];
            result = result.Where(p => p.FirstName.ToLower().Contains(name.ToLower())).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByLastname(string lastname)
        {
            var result = (List<ApplicationUser>)ViewState["lstProject"];
            result = result.Where(p => p.LastName.ToLower().Contains(lastname.ToLower())).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByUsername(string username)
        {
            var result = (List<ApplicationUser>)ViewState["lstProject"];
            result = result.Where(p => p.UserName.ToLower().Contains(username.ToLower())).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByLastModifiedDate(string email)
        {
            var result = (List<ApplicationUser>)ViewState["lstProject"];
            result = result.Where(p => p.Email.ToLower().Contains(email.ToLower())).ToList();
            ViewState["lstProject"] = result;
        }

    }
}