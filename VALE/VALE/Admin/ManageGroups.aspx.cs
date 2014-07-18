using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System.Linq.Expressions;
using VALE.Logic;

namespace VALE.MyVale.Create
{
    public partial class ManageGroups : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            var _db = new UserOperationsContext();

            if (lblGroupId.Value != "")
            {
                var groupActions = new GroupActions();
                var id = Convert.ToInt32(lblGroupId.Value);
                var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
                if (group != null)
                {
                    var list = _db.UserDatas.ToList().Except(group.Users).AsQueryable();
                    return list;
                }

            }
            return _db.UserDatas;
        }

        public IQueryable<VALE.Models.UserData> grdGroupUsers_GetData()
        {
            var _db = new UserOperationsContext();

            if (lblGroupId.Value != "")
            {
                var id = Convert.ToInt32(lblGroupId.Value);
                var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
                if (group != null)
                    return group.Users.AsQueryable();
            }
            return null;
        }

        protected void btnGroupsListButton_Click(object sender, EventArgs e)
        {
            pnlGroupList.Visible = true;
            pnlManageGroupPanel.Visible = false;
            lblGroupId.Value = "";
            grdGroups.DataBind();
            btnAddGroupButton.Visible = true;
            btnGroupsListButton.Visible = false;
        }

        protected void btnOkForNewGroupButton_Click(object sender, EventArgs e)
        {
            var action = lblGroupAction.Text;
            if (action == "Add")
            {
                var _db = new UserOperationsContext();

                Group group = new Group();
                group.CreationDate = DateTime.Now;
                group.GroupName = NameTextBox.Text;
                group.Description = DescriptionTextarea.InnerText;
                _db.Groups.Add(group);
                _db.SaveChanges();
                grdGroups.DataBind();
                grdGroupUsers.Visible = false;
                grdGroups.Visible = true;
            }
            else if (action == "Edit")
            {
                var _db = new UserOperationsContext();

                var id = Convert.ToInt16(lblGroupId.Value);
                var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
                if (group != null)
                {
                    group.GroupName = NameTextBox.Text;
                    group.Description = DescriptionTextarea.InnerText;
                    _db.SaveChanges();
                    grdGroups.DataBind();
                    grdGroupUsers.Visible = false;
                    grdGroups.Visible = true;
                }
            }
            else if (action == "Details")
                ModalPopup.Hide();
            
        }

        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        public IQueryable<Group> grdGroups_GetData()
        {
            var _db = new UserOperationsContext();
            return _db.Groups;
        }

        protected void grdGroups_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "ShowGroup":
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
            var _db = new UserOperationsContext();
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null) 
            {
                lblGroupId.Value = id.ToString();
                grdGroupUsers.Visible = true;
                grdGroupUsers.DataBind();
                grdUsers.DataBind();
                pnlGroupList.Visible = false;
                pnlManageGroupPanel.Visible = true;
                btnAddGroupButton.Visible = false;
                btnGroupsListButton.Visible = true;
                lblHeaderGroupPanel.Text = group.GroupName;
          
            }
            
        }

        private void DeleteGroup(int id)
        {
            var _db = new UserOperationsContext();
            var group = _db.Groups.Where(g => g.GroupId == id).FirstOrDefault();
            if (group != null) 
            {
                _db.Groups.Remove(group);
                _db.SaveChanges();
                grdGroupUsers.Visible = false;
                grdGroups.Visible = true;
                grdGroups.DataBind();
            }
        }

        private void EditGroup(int id)
        {
            var _db = new UserOperationsContext();
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
            var _db = new UserOperationsContext();
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

        protected void btnAddSelectedUsersToGroupButton_Click(object sender, EventArgs e)
        {
            using (var groupActions = new GroupActions())
            {
                var groupId = Convert.ToInt32(lblGroupId.Value);
                for (int i = 0; i < grdUsers.Rows.Count; i++)
                {
                    CheckBox chkBox = (CheckBox)grdUsers.Rows[i].Cells[0].FindControl("chkSelectUser");
                    if (chkBox.Checked)
                    {
                        chkBox.Checked = false;
                        var userName = ((Label)grdUsers.Rows[i].Cells[1].FindControl("labelUserName")).Text;
                        groupActions.AddUserToGroup(groupId, userName);
                    }
                }
                grdGroupUsers.DataBind();
                grdUsers.DataBind();
         
            }
            
        }

        protected void btnRemoveSelectedUsersFromGroupButton_Click(object sender, EventArgs e)
        {
            using (var groupActions = new GroupActions())
            {
                var groupId = Convert.ToInt32(lblGroupId.Value);
                for (int i = 0; i < grdGroupUsers.Rows.Count; i++)
                {
                    CheckBox chkBox = (CheckBox)grdGroupUsers.Rows[i].Cells[0].FindControl("chkSelectUser");
                    if (chkBox.Checked)
                    {
                        var userName = ((Label)grdGroupUsers.Rows[i].Cells[1].FindControl("labelUserName")).Text;
                        groupActions.RemoveUserFromGroup(groupId, userName);
                    }
                }
                grdGroupUsers.DataBind();
                grdUsers.DataBind();
            }

        }

        protected void grdUsersSelectDeselectAllLinkButton_Click(object sender, EventArgs e)
        {
            if (grdUsersSelectAllLabel.Text == "False")
            {
                SelectDeselectAllCheckBox(grdUsers, true);
                grdUsersSelectAllLabel.Text = "True";
            }
            else 
            {
                SelectDeselectAllCheckBox(grdUsers, false);
                grdUsersSelectAllLabel.Text = "False";
            }
        }

        protected void grdGroupUsersSelectDeselectAllLinkButton_Click(object sender, EventArgs e)
        {
            if (grdGroupUsersSelectAllLabel.Text == "False")
            {
                SelectDeselectAllCheckBox(grdGroupUsers, true);
                grdGroupUsersSelectAllLabel.Text = "True";
            }
            else 
            {
                SelectDeselectAllCheckBox(grdGroupUsers, false);
                grdGroupUsersSelectAllLabel.Text = "False";
            }
        }

        private void SelectDeselectAllCheckBox(GridView gridView, bool select)
        {
            for (int i = 0; i < gridView.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)gridView.Rows[i].Cells[0].FindControl("chkSelectUser");
                chkBox.Checked = select;
            }
        }

       
    }
}