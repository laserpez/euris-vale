using Microsoft.AspNet.Identity.EntityFramework;
//using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using VALE.Logic;
using VALE.Models;
using VALE.StateInfo;

namespace VALE.Admin
{
    public partial class ManageUsers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            if (!IsPostBack)
            {
                grdUsers.Columns[9].Visible = false;
                if (GetWaitingUsers().Count() > 0)
                {
                    PreparePanelForManage();
                    ListUsersType.Text = "Requests";
                    PreparePanelForRegistrationRequest();
                    btnSelectUsersType.InnerHtml = "Richieste" + " <span class=\"caret\">";
                }
                LoadData();
            }
            if (GetWaitingUsers().Count() == 0)
                btnConfirmUser.Visible = false;

            string password = Password.Text;
            Password.Attributes.Add("value", password);
            string confirmPassword = ConfirmPassword.Text;
            ConfirmPassword.Attributes.Add("value", confirmPassword);
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ManageUsers.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public IQueryable<ApplicationUser> GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            var users = db.Users.Where(u => u.NeedsApproval == true);
            return users;
        }

        public IQueryable<IdentityRole> GetRoles()
        {
            var db = new ApplicationDbContext();
            return db.Roles;
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
                    
                    var db = new ApplicationDbContext();
                    var newUser = db.Users.FirstOrDefault(u => u.UserName == userName);
                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                    AdminActions.ComposeMessage(manager, newUser.Id, " ", "Conferma richiesta");
                    //MailHelper.SendMail(grdUsers.Rows[i].Cells[1].Text, "La tua richiesta di associazione è stata confermata.", "VALE: Account confermato.");
                }
            }
            string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
            Response.Redirect(pageUrl);
        }

        protected void btnChangeUser_Click(object sender, EventArgs e)
        {

            LinkButton button = (LinkButton)sender;
            var actions = new UserActions();
            var rowId = ((GridViewRow)((LinkButton)sender).Parent.Parent.Parent.Parent).RowIndex;
            var username = (string)grdUsers.DataKeys[rowId].Value;
            if (username != HttpContext.Current.User.Identity.Name)
                if (!actions.ChangeUserRole(username,button.CommandArgument))
                {
                    lblChangeRole.Text = "Errore nella modifica dell'utente " + button.CommandArgument + ".";
                    lblChangeRole.ForeColor = System.Drawing.Color.Red;
                    lblChangeRole.Visible = true;
                }
            LoadData();
        }

        private void PreparePanelForRegistrationRequest()
        {
            //grdUsers.Columns[8].Visible = false;
            grdUsers.Columns[9].Visible = true;
            NotificationNumber.Visible = true;
            btnConfirmUser.Visible = true;
            HeaderName.Text = " Richieste Di Registrazione";
        }

        private void PreparePanelForManage()
        {
            //grdUsers.Columns[8].Visible = true;
            grdUsers.Columns[9].Visible = false;
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

        protected void grdUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdUsers.PageIndex = e.NewPageIndex;
            LoadData();
        }

        protected void grdUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "No" || e.CommandName == "Yes") 
            {
                string userName = e.CommandArgument.ToString();
                var db = new ApplicationDbContext();
                var user = db.Users.FirstOrDefault(u => u.UserName == userName);
                if (user != null) 
                {
                    if (e.CommandName == "Yes")
                        user.IsPartner = true;
                    else if (e.CommandName == "No")
                        user.IsPartner = false;
                    db.SaveChanges();
                    LoadData();
                }
            }
            
        }

        //-----------------------------------------------------------------------------------------

        private void ClearDropDownList()
        {
            List<string> init = new List<string> { "Seleziona" };
            Province.DataSource = init;
            Province.DataBind();
            City.DataSource = init;
            City.DataBind();
        }

        private void SetRegionDropDownList()
        {
            ClearDropDownList();
            String path = Server.MapPath("~/StateInfo/regioni_province_comuni.xml");
            StateInfoXML.GetInstance().FileName = path;
            var list = StateInfoXML.GetInstance().LoadData();
            var regions = (from r in list where r.depth == "0" orderby r.name select r.name).ToList();
            regions.Insert(0, "Seleziona");
            Region.DataSource = regions;
            Region.DataBind();
        }

        protected void Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Region.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                Province.DataSource = init;
                Province.DataBind();
                City.DataSource = init;
                City.DataBind();
            }
            else
            {
                ClearDropDownList();
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "0" && r.name == Region.SelectedValue select r.tid).FirstOrDefault();
                var provinces = (from r in list where r.depth == "1" && r.parent == tid orderby r.name select r.name).ToList();
                provinces.Insert(0, "Seleziona");
                Province.DataSource = provinces;
                Province.DataBind();
                Province.Focus();
            }
            ModalPopupAddUser.Show();
        }

        protected void Province_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Province.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                City.DataSource = init;
                City.DataBind();
            }
            else
            {
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "1" && r.name == Province.SelectedValue select r.tid).FirstOrDefault();
                var citys = (from r in list where r.depth == "2" && r.parent == tid orderby r.name select r.name).ToList();
                citys.Insert(0, "Seleziona");
                City.DataSource = citys;
                City.DataBind();
                City.Focus();
            }
            ModalPopupAddUser.Show();
        }

        public List<PartnerType> ddlPartnerType_GetData()
        {
            var db = new UserOperationsContext();
            return db.PartnerTypes.ToList();
        }

        protected void checkAssociated_CheckedChanged(object sender, EventArgs e)
        {
            if (checkAssociated.Checked)
            {
                pnlPartnerType.Visible = true;
                pnlPartnerType.Focus();
            }

            else
            {
                pnlPartnerType.Visible = false;
                checkAssociated.Focus();
            }
            ModalPopupAddUser.Show();
        }

        protected void btnPopUpAddUserOk_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser()
            {
                UserName = TextUserName.Text,
                FirstName = TextFirstName.Text,
                LastName = TextLastName.Text,
                Telephone = TextTelephone.Text,
                CellPhone = TextCellPhone.Text,
                CF = TextCF.Text == "" ? null : TextCF.Text,
                NeedsApproval = false,
                IsPartner = checkAssociated.Checked,
                Email = Email.Text,
                
            };
            if (Region.SelectedIndex != 0)
                user.Region = Region.SelectedValue;
            else
                user.Region = "";
            if (Province.SelectedIndex != 0)
                user.Province = Province.SelectedValue;
            else
                user.Province = "";
            if (City.SelectedIndex != 0)
                user.City = City.SelectedValue;
            else
                user.City = "";
            user.Address = TextAddress.Text;

            user.PartnerType = checkAssociated.Checked ? ddlPartnerType.SelectedValue : "Generico";
            var passwordValidator = new PasswordValidator();
            //per la password sono richiesti solo sei caratteri
            passwordValidator.RequiredLength = 6;
            manager.PasswordValidator = passwordValidator;
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                if (checkAssociated.Checked)
                    manager.AddToRole(user.Id, "Socio");
                else
                    manager.AddToRole(user.Id, "Utente");
                db.UserDatas.Add(new UserData
                {
                    UserName = user.UserName,
                    Email = user.Email,
                    FullName = user.FirstName + " " + user.LastName
                });
                db.SaveChanges();
                LoadData();
            }
            else
            {
                lblError.Visible = true;
                lblError.Text = result.Errors.FirstOrDefault();
                ModalPopupAddUser.Show();
            }
        }

        protected void btnPopUpAddUserClose_Click(object sender, EventArgs e)
        {
            ModalPopupAddUser.Hide();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            TextUserName.Text = "";
            Password.Text = "";
            Password.Attributes.Add("value", "");
            ConfirmPassword.Text = "";
            ConfirmPassword.Attributes.Add("value", "");
            TextFirstName.Text = "";
            TextLastName.Text = "";
            TextCF.Text = "";
            Email.Text = "";
            TextCellPhone.Text = "";
            TextTelephone.Text = "";
            SetRegionDropDownList();
            TextAddress.Text = "";
            pnlPartnerType.Visible = false;
            checkAssociated.Checked = false;
            ModalPopupAddUser.Show();
        }



    }
}