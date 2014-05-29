using System;
using System.Collections.Generic;
using System.Linq;
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
            if (users.Count() == 0)
                btnConfirmUser.Enabled = false;
            
        }

        public IQueryable<ApplicationUser> GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users.Where(u => u.NeedsApproval == true);
            return users;
        }

        public IQueryable<ApplicationUser> GetUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users;
            return users;
        }

        public string GetRoleName(string userID)
        {
            var db = new ApplicationDbContext();
            string roleName,roleId;
            roleId = db.Users.Where(o => o.Id == userID).FirstOrDefault().Roles.FirstOrDefault().RoleId;
            roleName = db.Roles.Where(o => o.Id == roleId).FirstOrDefault().Name;
            return roleName;
        }

        protected void btnConfimUser_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < grdWaitingUsers.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)grdWaitingUsers.Rows[i].FindControl("chkSelectUser");
                if (chkBox.Checked)
                {
                    string userId = grdWaitingUsers.Rows[i].Cells[0].Text;
                    AdminActions.ConfirmUser(userId);
                    //MailHelper.SendMail(WaitingUsers.Rows[i].Cells[1].Text, "Your associated account has been confirmed", "Account confirmed");
                }
            }
            grdWaitingUsers.DataBind();
        }

        protected void btnChangeUser_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            if (button.Text == "Administrator")
            {
                lblChangeRole.Text = UserActions.ChangeUserRole(button.CommandArgument, "Administrator");
                if (lblChangeRole.Text != "")
                    lblChangeRole.Visible = true;
            }
            else if (button.Text == "BoardMember")
            {
                lblChangeRole.Text = UserActions.ChangeUserRole(button.CommandArgument, "BoardMember");
                if (lblChangeRole.Text != "")
                    lblChangeRole.Visible = true;
            }
            else if (button.Text == "AssociatedUser")
            {
                lblChangeRole.Text = UserActions.ChangeUserRole(button.CommandArgument, "AssociatedUser");
                if (lblChangeRole.Text != "")
                    lblChangeRole.Visible = true;
            }
            grdUsers.DataBind();
        }
    }
}