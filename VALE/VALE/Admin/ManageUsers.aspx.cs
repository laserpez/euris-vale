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
    }
}