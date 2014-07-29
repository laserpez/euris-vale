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
using System.Linq.Expressions;
using VALE.Logic;

namespace VALE.MyVale
{
    [Serializable]
    public class UserInfo
    {
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string CellPhone { get; set; }
        public string Telephone { get; set; }
    }

    public partial class UserList : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            if (!IsPostBack)
            {
                filterPanel.Visible = false;
                ViewState["UserInfo"] = GetUsers().ToList();
                grdUsers.DataSource = (List<UserInfo>)ViewState["UserInfo"];
                grdUsers.DataBind();
            }
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "ListaUtenti"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina UserList.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public IQueryable<UserInfo> GetUsers()
        {
            var textname = txtName.Text;
            var textusername = txtUsername.Text;
            var textlastname = txtLastname.Text;
            var textemail = txtEmail.Text;
            var db = new ApplicationDbContext();
            var users = db.Users.Where(o => o.UserName != "Admin");
            if (textname != null)
                users = users.Where(u => u.FirstName.ToUpper().Contains(textname));
            if (textlastname != null)
                users = users.Where(u => u.LastName.ToUpper().Contains(textlastname));
            if (textusername != null)
                users = users.Where(u => u.UserName.ToUpper().Contains(textusername));
            if (textemail != null)
                users = users.Where(u => u.Email.Contains(textemail));

            var usersInfo = users.Select(u => new UserInfo { Username = u.UserName, FirstName = u.FirstName, LastName = u.LastName, Email = u.Email, CellPhone = u.CellPhone });
            return usersInfo;
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            ViewState["UserInfo"] = GetUsers().ToList();
            grdUsers.DataSource = (List<UserInfo>)ViewState["UserInfo"];
            grdUsers.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtEmail.Text = null;
            txtLastname.Text = null;
            txtName.Text = null;
            txtUsername.Text = null;
            ViewState["UserInfo"] = GetUsers().ToList();
            grdUsers.DataSource = (List<UserInfo>)ViewState["UserInfo"];
            grdUsers.DataBind();
        }

        protected void grdUsers_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;

            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            ViewState["UserInfo"] = GetSortedData(e.SortExpression);
            grdUsers.DataSource = (List<UserInfo>)ViewState["UserInfo"];
            grdUsers.DataBind();
        }

        private List<UserInfo> GetSortedData(string sortExpression)
        {
            var result = (List<UserInfo>)ViewState["UserInfo"];

            var param = Expression.Parameter(typeof(UserInfo), sortExpression);
            var sortBy = Expression.Lambda<Func<UserInfo, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                result = result.AsQueryable<UserInfo>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<UserInfo>().OrderBy(sortBy).ToList();
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

        protected void grdUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdUsers.PageIndex = e.NewPageIndex;
            grdUsers.DataSource = (List<UserInfo>)ViewState["UserInfo"];
            grdUsers.DataBind();
        }
    }
}