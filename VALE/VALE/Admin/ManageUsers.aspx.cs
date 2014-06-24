﻿//using Microsoft.Ajax.Utilities;
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
                
                var lstUsers = GetUsers();
                grdUsers.DataSource = lstUsers;
                grdUsers.DataBind();
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
            for (int i = 0; i < grdUsers.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)grdUsers.Rows[i].FindControl("chkSelectUser");
                if (chkBox.Checked)
                {
                    string userName = grdUsers.Rows[i].Cells[0].Text;
                    AdminActions.ConfirmUser(userName);
                    string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                    Response.Redirect(pageUrl);
                    //MailHelper.SendMail(WaitingUsers.Rows[i].Cells[1].Text, "Your associated account has been confirmed", "Account confirmed");
                }
            }
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
            Response.Redirect("~/Admin/ManageUsers");
        }

        private void PreparePanelForRegistrationRequest()
        {
            grdUsers.Columns[8].Visible = false;
            grdUsers.Columns[7].Visible = true;
            NotificationNumber.Visible = true;
            btnConfirmUser.Visible = true;
            TitleLabel.Text = " Richieste Di Registrazione";
        }

        private void PreparePanelForManage()
        {
            grdUsers.Columns[8].Visible = true;
            grdUsers.Columns[7].Visible = false;
            NotificationNumber.Visible = false;
            btnConfirmUser.Visible = false;
            TitleLabel.Text = " Gestione Utenti";

            GetAllUsersButton.Visible = false;
            GetAdminButton.Visible = false;
            GetPartnersButton.Visible = false;
            GetDirectivPartnersButton.Visible = false;
            GetRequestsdButton.Visible = false;
        }

        protected void GetAllUsers_Click(object sender, EventArgs e)
        {
            PreparePanelForManage();
            ListUsersType.Text = "Tutti";
            GetAllUsersButton.Visible = true;
            LoadData();
        }

        protected void GetPartners_Click(object sender, EventArgs e)
        {
            PreparePanelForManage();
            ListUsersType.Text = "Soci";
            GetPartnersButton.Visible = true;
            LoadData();
        }

        protected void GetAdmin_Click(object sender, EventArgs e)
        {
            PreparePanelForManage();
            ListUsersType.Text = "Amministratori";
            GetAdminButton.Visible = true;
            LoadData();
        }

        protected void GetDirectivPartners_Click(object sender, EventArgs e)
        {
            PreparePanelForManage();
            ListUsersType.Text = "Membri";
            GetDirectivPartnersButton.Visible = true;
            LoadData();
        }

        protected void GetRequests_Click(object sender, EventArgs e)
        {
            PreparePanelForRegistrationRequest();
            GetAllUsersButton.Visible = false;
            GetAdminButton.Visible = false;
            GetPartnersButton.Visible = false;
            GetDirectivPartnersButton.Visible = false;
            ListUsersType.Text = "Richieste";
            GetRequestsdButton.Visible = true;
            LoadData();
        }
        private void LoadData()
        {
            var db = new ApplicationDbContext();
            List<ApplicationUser> list = new List<ApplicationUser>();

            switch (ListUsersType.Text)
            {
                case "Tutti":
                    list = db.Users.ToList();
                    break;
                case "Amministratori":
                    var rolesA = db.Roles.Where(p => p.Name == "Amministratore").Select(k => k.Id).FirstOrDefault();
                    list = db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesA).ToList();
                    break;
                case "Soci":
                    var rolesS = db.Roles.Where(p => p.Name == "Socio").Select(k => k.Id).FirstOrDefault();
                    list = db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesS ).ToList();
                    break;
                case "Membri":
                    var rolesM = db.Roles.Where(p => p.Name == "Membro del consiglio").Select(k => k.Id).FirstOrDefault();
                    list = db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesM).ToList();
                    break;
                case "Richieste":
                    list = db.Users.Where(u => u.NeedsApproval == true).ToList();
                    break;
                default:
                    break;
            }
                    grdUsers.DataSource = list;
                    grdUsers.DataBind();
        }
    }
}