using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale.Create
{
    public partial class SelectUser : System.Web.UI.UserControl
    {
        public List<string> SelectedUsers
        {
            get
            {
                return (List<string>)ViewState["usersIds"];
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ViewState["usersIds"] = new List<string>();
            }
        }

        public IQueryable<UserData> GetUsers()
        {
            var _db = new UserOperationsContext();
            var result = _db.UsersData.OrderBy(u => u.UserName);
            return result;
        }

        public IQueryable<UserData> GetRelatedUsers()
        {
            List<string> userIds = (List<string>)ViewState["usersIds"];
            var db = new UserOperationsContext();
                return db.UsersData.Where(u => userIds.Contains(u.UserName));
        }

        public void DeleteUser(UserData user)
        {
            List<string> users = (List<string>)ViewState["usersIds"];
            users.Remove(user.UserName);
            ViewState["usersIds"] = users;
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void btnShowPopup_Click(object sender, EventArgs e)
        {
            ModalPopup.Show();
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            string userName = txtUserName.Text;
            var user = db.UsersData.FirstOrDefault(p => p.FullName == userName);
            if (user != null)
            {
                lblResultSearchUser.Text = String.Format("User {0} is now related to this project", txtUserName.Text);
                btnSearchUser.CssClass = "btn btn-success";
                List<string> users = (List<string>)ViewState["usersIds"];
                users.Add(user.UserName);
                ViewState["usersIds"] = users;
                lstUsers.DataBind();
            }
            else
            {
                lblResultSearchUser.Text = "This user does not exist";
                btnSearchUser.CssClass = "btn btn-warning";
            }
            txtUserName.Text = "";
        }

        protected void btnChooseUser_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            List<string> users = (List<string>)ViewState["usersIds"];
            users.Add(btn.CommandArgument);
            ViewState["usersIds"] = users;
            lstUsers.DataBind();
        }
    }
}