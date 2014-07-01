using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale.Create
{
    public partial class ManageGroups : System.Web.UI.Page
    {
        ApplicationDbContext _AppDb = new ApplicationDbContext();
        UserOperationsContext _db = new UserOperationsContext();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnManageGroupLinkButton_Click(object sender, EventArgs e)
        {
            ManageGroupLoadData();
            btnManageGroupButton.Visible = true;
            btnManageSetGroupsButton.Visible = false;
        }
        protected void btnManageSetGroupsLinkButton_Click(object sender, EventArgs e)
        {
            ManageSetGroupsLoadData();
            btnManageGroupButton.Visible = false;
            btnManageSetGroupsButton.Visible = true;
        }

        private void ManageGroupLoadData() 
        {
            pnlManageSetGroupsPanel.Visible = false;
            pnlManageGroupPanel.Visible = true;
        }

        private void ManageSetGroupsLoadData()
        {
            pnlManageSetGroupsPanel.Visible = true;
            pnlManageGroupPanel.Visible = false;
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

        public IQueryable<VALE.Models.ApplicationUser> grdUsers_GetData()
        {
            return _AppDb.Users;
        }

        protected void btnGroupsListButton_Click(object sender, EventArgs e)
        {

        }

        protected void btnAddGroupButton_Click(object sender, EventArgs e)
        {
            btnOkGroupButton.Text = "Crea"; 
            NameTextBox.CssClass = "form-control input-sm";
            DescriptionTextarea.Disabled = false;
            NameTextBox.Text = "";
            DescriptionTextarea.InnerText= "";
            lblGroupAction.Text = "Add";
            ModalPopup.Show();
        }

        protected void btnOkForNewGroupButton_Click(object sender, EventArgs e)
        {
            var action = lblGroupAction.Text;
            if (action == "Add")
            {
                Group group = new Group();
                group.CreationDate = DateTime.Now;
                group.GroupName = NameTextBox.Text;
                group.Description = DescriptionTextarea.InnerText;
                _db.Groups.Add(group);
                _db.SaveChanges();
                grdGroups.DataBind();
            }
            else if (action == "Edit")
            {

            }
            else if (action == "Details")
                ModalPopup.Hide();
            
        }

        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        public IQueryable<VALE.Models.Group> grdGroups_GetData()
        {
            return _db.Groups;
        }

        protected void grdGroups_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "ShowGroup":
                default:
                    ShowGroup(Convert.ToInt16(e.CommandArgument));
                    break;
                case "EditGroup":
                    EditGroup(Convert.ToInt16(e.CommandArgument));
                    break;
                case "DeleteGroup":
                    DeleteGroup(Convert.ToInt16(e.CommandArgument));
                    break;
            }
        }

        private void DeleteGroup(int id)
        {
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null) 
            {
                _db.Groups.Remove(group);
                _db.SaveChanges();
                grdGroups.DataBind();
            }
        }

        private void EditGroup(int id)
        {
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null) 
            {
                btnOkGroupButton.Text = "Salva";
                NameTextBox.CssClass = "form-control input-sm";
                DescriptionTextarea.Disabled = false;
                NameTextBox.Text = group.GroupName;
                DescriptionTextarea.InnerText = group.Description;
                lblGroupAction.Text = "Edit";
                lblGroupId.Text = "" + id;
                ModalPopup.Show();
            }
        }

        private void ShowGroup(int id)
        {
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null)
            {
                btnOkGroupButton.Text = "Ok";
                NameTextBox.CssClass = "form-control input-sm disabled";
                DescriptionTextarea.Disabled = true;
                NameTextBox.Text = group.GroupName;
                DescriptionTextarea.InnerText = group.Description;
                lblGroupAction.Text = "Details";
                ModalPopup.Show();
            }
        }

        
    }
}