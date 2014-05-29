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
            
        }

        public IQueryable<ApplicationUser> GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users.Where(u => u.NeedsApproval == true);
            return users;
        }

        protected void btnConfimUser_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < grdWaitingUsers.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)grdWaitingUsers.Rows[i].FindControl("chkSelectUser");
                if(chkBox.Checked)
                {
                    string userId = grdWaitingUsers.Rows[i].Cells[0].Text;
                    AdminActions.ConfirmUser(userId);
                    //MailHelper.SendMail(WaitingUsers.Rows[i].Cells[1].Text, "Your associated account has been confirmed", "Account confirmed");
                }
            }
            grdWaitingUsers.DataBind();
        }
    }
}