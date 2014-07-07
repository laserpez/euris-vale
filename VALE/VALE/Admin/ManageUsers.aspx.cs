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
            if (!IsPostBack)
            {
                grdUsers.Columns[7].Visible = false;
                LoadData();
            }

            if (GetWaitingUsers().Count() == 0)
                btnConfirmUser.Enabled = false;
        }

        public IQueryable<ApplicationUser> GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users.Where(u => u.NeedsApproval == true);
            return users;
        }

        public string GetRoleName(string userId)
        {
            using (var actions = new UserActions())
            {
                return actions.GetRole(userId);
            }

        }

        protected void btnConfimUser_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < grdUsers.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)grdUsers.Rows[i].FindControl("chkSelectUser");
                if (chkBox.Checked)
                {
                    string userName = ((Label)grdUsers.Rows[i].Cells[0].FindControl("labelUserName")).Text;
                    AdminActions.ConfirmUser(userName);
                    //MailHelper.SendMail(WaitingUsers.Rows[i].Cells[1].Text, "La tua richiesta di associazione è stata confermata.", "Account confermato");
                }
            }
            string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
            Response.Redirect(pageUrl);
        }

        protected void btnChangeUser_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            var actions = new UserActions();
            if (button.CommandName == "Administrator")
            {
                if (!actions.ChangeUserRole(button.CommandArgument, "Amministratore"))
                {
                    lblChangeRole.Text = "Errore nella modifica dell'utente " + button.CommandArgument + ".";
                    lblChangeRole.ForeColor = System.Drawing.Color.Red;
                    lblChangeRole.Visible = true;
                }
            }
            else if (button.CommandName == "BoardMember")
            {
                if (!actions.ChangeUserRole(button.CommandArgument, "Membro del consiglio"))
                {
                    lblChangeRole.Text = "Errore nella modifica dell'utente " + button.CommandArgument + ".";
                    lblChangeRole.ForeColor = System.Drawing.Color.Red;
                    lblChangeRole.Visible = true;
                }
            }
            else if (button.CommandName == "Associated")
            {
                if (!actions.ChangeUserRole(button.CommandArgument, "Socio"))
                {
                    lblChangeRole.Text = "Errore nella modifica dell'utente " + button.CommandArgument + ".";
                    lblChangeRole.ForeColor = System.Drawing.Color.Red;
                    lblChangeRole.Visible = true;
                }
            }
            LoadData();
        }

        private void PreparePanelForRegistrationRequest()
        {
            grdUsers.Columns[8].Visible = false;
            grdUsers.Columns[7].Visible = true;
            NotificationNumber.Visible = true;
            btnConfirmUser.Visible = true;
            HeaderName.Text = " Richieste Di Registrazione";
        }

        private void PreparePanelForManage()
        {
            grdUsers.Columns[8].Visible = true;
            grdUsers.Columns[7].Visible = false;
            NotificationNumber.Visible = false;
            btnConfirmUser.Visible = false;
            HeaderName.Text = " Gestione Utenti";

        }

        protected void GetSelectedUsers_Click(object sender, EventArgs e)
        {
            PreparePanelForManage();
            var button = (LinkButton)sender;
            string argument = button.CommandArgument;
            ListUsersType.Text = argument;

            if(argument == "Requests")
                PreparePanelForRegistrationRequest();
            btnSelectUsersType.InnerHtml = GetButtonName(button.Text) + " <span class=\"caret\">";
            LoadData();
        }

        private string GetButtonName(string html)
        {
            string[] lineTokens = html.Split('>');
            return lineTokens[2].Trim();
        }

        private void LoadData()
        {
            using (var actions = new UserActions())
            {
                grdUsers.DataSource = actions.GetFilteredData(ListUsersType.Text);
            }
            grdUsers.DataBind();
        }

        protected void grdUsers_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            using (var actions = new UserActions())
            {
                grdUsers.DataSource = actions.GetSortedData(e.SortExpression, GridViewSortDirection);
            }
            grdUsers.DataBind();
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
    }
}