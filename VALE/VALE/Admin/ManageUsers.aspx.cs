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

        //public List<ApplicationUser> GetUsers()
        //{
        //    var db = new ApplicationDbContext();
        //    var users = db.Users.ToList();
        //    return users;
        //}

        public string GetRoleName(string userId)
        {
            using (var actions = new UserActions())
            {
                return actions.GetRole(userId);
            }

            //var db = new ApplicationDbContext();
            //var user = db.Users.First(u => u.Id == userId);
            //if (user.Roles.Count != 0)
            //{
            //    var roleId = user.Roles.First().RoleId;
            //    var roleName = db.Roles.FirstOrDefault(o => o.Id == roleId).Name;
            //    return roleName;
            //}
            //else
            //    return "Utente";
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

            //((SiteMaster)Master).UpdateNavbar();
            grdUsers.DataBind();
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

            GetAllUsersButton.Visible = false;
            GetAdminButton.Visible = false;
            GetPartnersButton.Visible = false;
            GetDirectivPartnersButton.Visible = false;
            GetRequestsdButton.Visible = false;
        }

        protected void GetSelectedUsers_Click(object sender, EventArgs e)
        {
            PreparePanelForManage();
            string input = ((LinkButton)sender).Text;
            ListUsersType.Text = CleanSender(input);

            switch (ListUsersType.Text)
            { 
                case "Soci":
                    GetPartnersButton.Visible = true;
                    break;
                case "Amministratori":
                    GetAdminButton.Visible = true;
                    break;
                case "Membri":
                    GetDirectivPartnersButton.Visible = true;
                    break;
                case "Richieste":
                    GetAllUsersButton.Visible = false;
                    GetAdminButton.Visible = false;
                    GetPartnersButton.Visible = false;
                    GetDirectivPartnersButton.Visible = false;
                    GetRequestsdButton.Visible = true;
                    break;
                default :
                    GetAllUsersButton.Visible = true;
                    break;
            }
            LoadData();
        }

        private string CleanSender(string input)
        {
            Char[] separators = new Char[] { ' ' };
            string[] splittedInput = input.Split(separators, StringSplitOptions.RemoveEmptyEntries);
            return splittedInput.LastOrDefault();
        }

        private void LoadData()
        {
            //var db = new ApplicationDbContext();
            //List<ApplicationUser> list = new List<ApplicationUser>();
            //switch (ListUsersType.Text)
            //{
            //    case "Amministratori":
            //        var rolesA = db.Roles.Where(p => p.Name == "Amministratore").Select(k => k.Id).FirstOrDefault();
            //        list = db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesA).ToList();
            //        break;
            //    case "Soci":
            //        var rolesS = db.Roles.Where(p => p.Name == "Socio").Select(k => k.Id).FirstOrDefault();
            //        list = db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesS ).ToList();
            //        break;
            //    case "Membri":
            //        var rolesM = db.Roles.Where(p => p.Name == "Membro del consiglio").Select(k => k.Id).FirstOrDefault();
            //        list = db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesM).ToList();
            //        break;
            //    case "Richieste":
            //        list = db.Users.Where(u => u.NeedsApproval == true).ToList();
            //        break;
            //    default:
            //        list = db.Users.ToList();
            //        break;
            //}
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

            //grdUsers.DataSource = GetSortedData(e.SortExpression);

            using (var actions = new UserActions())
            {
                grdUsers.DataSource = actions.GetSortedData(e.SortExpression, GridViewSortDirection);
            }
            grdUsers.DataBind();
        }

        //private List<ApplicationUser> GetSortedData(string sortExpression)
        //{
        //    var result = GetUsers();
        //    if (sortExpression != "Ruolo")
        //    {
        //        var param = Expression.Parameter(typeof(ApplicationUser), sortExpression);
        //        var sortBy = Expression.Lambda<Func<ApplicationUser, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

        //        if (GridViewSortDirection == SortDirection.Descending)
        //            result = result.AsQueryable<ApplicationUser>().OrderByDescending(sortBy).ToList();
        //        else
        //            result = result.AsQueryable<ApplicationUser>().OrderBy(sortBy).ToList();
        //    }
        //    else
        //    {
        //        if (GridViewSortDirection == SortDirection.Descending)
        //            result = result.AsQueryable<ApplicationUser>().OrderByDescending(u => GetRoleName(u.Id)).ToList();
        //        else
        //            result = result.AsQueryable<ApplicationUser>().OrderBy(u => GetRoleName(u.Id)).ToList();
        //    }

        //    return result;
        //}

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