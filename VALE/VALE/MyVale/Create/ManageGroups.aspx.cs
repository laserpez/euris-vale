using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.MyVale.Create
{
    public partial class ManageGroups : System.Web.UI.Page
    {
        UserOperationsContext _db = new UserOperationsContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Mode"] != null) 
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                string action = Request.QueryString["Action"];
                if (Request.QueryString["Mode"] == "Group")
                {
                    int groupId = Convert.ToInt16(Request.QueryString["GroupId"]);
                    string userName = Request.QueryString["UserName"];
                    ManageGroup(action, userName, groupId);
                }
                else if (Request.QueryString["Mode"] == "SetGroups")
                {
                    
                }
            }
        }

        private void ManageGroup(string action, string userName, int groupId)
        {
            using(var groupActions = new GroupActions())
            {
                if (action == "Add") 
                {
                    if (!groupActions.IsUserRelated(groupId, userName))
                        groupActions.AddUserToGroup(groupId, userName);
                }
                else if (action == "Remove")
                {
                    groupActions.RemoveUserFromGroup(groupId, userName);
                }
                    
                grdGroupUsers.DataBind();
                grdUsers.DataBind();
            }
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
            lblMode.Value = "Group"; 
            pnlManageSetGroupsPanel.Visible = false;
            pnlManageGroupPanel.Visible = true;
        }

        private void ManageSetGroupsLoadData()
        {
            lblMode.Value = "SetGroups";
            pnlManageSetGroupsPanel.Visible = true;
            pnlManageGroupPanel.Visible = false;
        }

        public string GetRoleName(string userName)
        {
            var db = new ApplicationDbContext();
            var user = db.Users.First(u => u.UserName == userName);
            if (user.Roles.Count != 0)
            {
                var roleId = user.Roles.First().RoleId;
                var roleName = db.Roles.FirstOrDefault(o => o.Id == roleId).Name;
                return roleName;
            }
            else
                return "Utente";
        }

        public IQueryable<VALE.Models.UserData> grdUsers_GetData()
        {
            if (lblGroupId.Value != "")
            {
                var groupActions = new GroupActions();
                var id = Convert.ToInt32(lblGroupId.Value);
                var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
                if (group != null)
                    return _db.UserDatas.ToList().Except(group.Users).AsQueryable();
            }
            return _db.UserDatas;
        }

        public IQueryable<VALE.Models.UserData> grdGroupUsers_GetData()
        {
            int id = 0;
            if (int.TryParse(lblGroupId.Value, out id)) 
            {
                var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
                if (group != null)
                    return group.Users.AsQueryable();
            }
            return null;
        }

        protected void btnGroupsListButton_Click(object sender, EventArgs e)
        {
            lblGroupId.Value = "";
            grdGroupUsers.Visible = false;
            grdGroups.Visible = true;
            grdGroups.DataBind();
            grdUsers.DataBind();
            btnAddGroupButton.Visible = true;
            btnGroupsListButton.Visible = false;
            lblHeaderGroupPanel.Text = "Gruppi";
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
                var id = Convert.ToInt16(lblGroupId.Value);
                var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
                if (group != null)
                {
                    group.GroupName = NameTextBox.Text;
                    group.Description = DescriptionTextarea.InnerText;
                    _db.SaveChanges();
                    grdGroups.DataBind();
                }
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
                    ShowGroup(Convert.ToInt32(e.CommandArgument));
                    break;
                case "EditGroup":
                    EditGroup(Convert.ToInt32(e.CommandArgument));
                    break;
                case "DeleteGroup":
                    DeleteGroup(Convert.ToInt32(e.CommandArgument));
                    break;
                case "OpenGroup":
                    OpenGroup(Convert.ToInt32(e.CommandArgument));
                    break;
            }
        }

        private void OpenGroup(int id)
        {
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null) 
            {
                lblGroupId.Value = id + "";
                grdGroupUsers.Visible = true;
                grdGroupUsers.DataBind();
                grdUsers.DataBind();
                grdGroups.Visible = false;
                btnAddGroupButton.Visible = false;
                btnGroupsListButton.Visible = true;
                lblHeaderGroupPanel.Text = group.GroupName;
                ApplyDragAndDrop();
            }
            
        }

        private void ApplyDragAndDrop()
        {
            string dragAndDrop = @"$(function () {
            $('.table').sortable({
                items: 'tr:not(tr:first-child)',
                cursor: 'crosshair',
                connectWith: '.table',
                dropOnEmpty: true,
                receive: function (e, ui) {
                    $(this).find('tbody').append(ui.item);
                   
                    var mode = document.getElementById('MainContent_lblMode').value;
                    var receverTableId = this.id;
                    var action = '';
                    if(mode == 'Group')
                    {
                        var userName = ui.item.find('td')[1].innerText;
                        var groupId = document.getElementById('MainContent_lblGroupId').value;
                        if(receverTableId == 'MainContent_grdGroupUsers')
                            action = 'Add';
                        if(receverTableId == 'MainContent_grdUsers')
                            action = 'Remove';
                        ManageGroup(action, userName, groupId);
                    }
                    else
                        alert('Boohhhh');
                    }
                });
            });";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "dragAndDrop", dragAndDrop, true);
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
                btnClosePopUpButton.Visible = true;
                btnOkGroupButton.Text = "Salva";
                NameTextBox.Enabled = true;
                NameTextBox.CssClass = "form-control input-sm";
                DescriptionTextarea.Disabled = false;
                NameTextBox.Text = group.GroupName;
                DescriptionTextarea.InnerText = group.Description;
                lblGroupAction.Text = "Edit";
                lblGroupId.Value = "" + id;
                ModalPopup.Show();
            }
        }

        private void ShowGroup(int id)
        {
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null)
            {
                btnClosePopUpButton.Visible = false;
                btnOkGroupButton.Text = "Chiudi";
                NameTextBox.Enabled = false;
                NameTextBox.CssClass = "form-control input-sm disabled";
                DescriptionTextarea.Disabled = true;
                NameTextBox.Text = group.GroupName;
                DescriptionTextarea.InnerText = group.Description;
                lblGroupAction.Text = "Details";
                ModalPopup.Show();
            }
        }

        protected void btnAddGroupButton_Click(object sender, EventArgs e)
        {
            btnOkGroupButton.Text = "Crea";
            btnClosePopUpButton.Visible = true;
            NameTextBox.Enabled = true;
            NameTextBox.CssClass = "form-control input-sm";
            DescriptionTextarea.Disabled = false;
            NameTextBox.Text = "";
            DescriptionTextarea.InnerText = "";
            lblGroupAction.Text = "Add";
            ModalPopup.Show();
        }

        
    }
}