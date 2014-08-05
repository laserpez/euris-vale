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
    public partial class ManageProjectTypes : Page
    {
        UserOperationsContext _db = new UserOperationsContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();

        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ManageProjectTypes.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        protected void btnAddTypeButton_Click(object sender, EventArgs e)
        {
            btnOkButton.Text = "Crea";
            btnClosePopUpButton.Visible = true;
            NameTextBox.Enabled = true;
            NameTextBox.CssClass = "form-control input-sm";
            DescriptionTextarea.Disabled = false;
            NameTextBox.Text = "";
            DescriptionTextarea.InnerText = "";
            lblTypeAction.Text = "Add";
            ModalPopup.Show();
        }

        protected void grdTypes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "ShowType":
                    ShowType(Convert.ToInt32(e.CommandArgument));
                    break;
                case "EditType":
                    EditType(Convert.ToInt32(e.CommandArgument));
                    break;
                case "DeleteType":
                    DeleteType(Convert.ToInt32(e.CommandArgument));
                    break;
                case "Page":
                    break;
            }
        }



        private void DeleteType(int typeId)
        {
            var projectType = _db.ProjectTypes.Where(p => p.ProjectTypeId == typeId).FirstOrDefault();
            if (projectType != null)
            {
                _db.ProjectTypes.Remove(projectType);
                _db.SaveChanges();
                grdTypes.PageIndex = 0;
                grdTypes.DataBind();
            }
        }

        private void EditType(int typeId)
        {
            var projectType = _db.ProjectTypes.Where(p => p.ProjectTypeId == typeId).FirstOrDefault();
            if (projectType != null)
            {
                btnClosePopUpButton.Visible = true;
                btnOkButton.Text = "Salva";
                NameTextBox.Enabled = true;
                NameTextBox.CssClass = "form-control input-sm";
                DescriptionTextarea.Disabled = false;
                NameTextBox.Text = projectType.ProjectTypeName;
                DescriptionTextarea.InnerText = projectType.Description;
                lblTypeAction.Text = "Edit";
                lblTypeId.Value = typeId.ToString();
                ModalPopup.Show();
            }
        }

        private void ShowType(int typeId)
        {
            var projectType = _db.ProjectTypes.Where(p => p.ProjectTypeId == typeId).FirstOrDefault();
            if (projectType != null)
            {
                btnClosePopUpButton.Visible = false;
                btnOkButton.Text = "Chiudi";
                NameTextBox.Enabled = false;
                NameTextBox.CssClass = "form-control input-sm disabled";
                DescriptionTextarea.Disabled = true;
                NameTextBox.Text = projectType.ProjectTypeName;
                DescriptionTextarea.InnerText = projectType.Description;
                lblTypeAction.Text = "Details";
                ModalPopup.Show();
            }
        }


        protected void btnOkButton_Click(object sender, EventArgs e)
        {
            var action = lblTypeAction.Text;
            if (action == "Add")
            {
                ProjectType projectType = new ProjectType();
                projectType.CreationDate = DateTime.Now;
                projectType.ProjectTypeName = NameTextBox.Text;
                projectType.Description = DescriptionTextarea.InnerText;
                _db.ProjectTypes.Add(projectType);
                _db.SaveChanges();
                grdTypes.DataBind();
            }
            else if (action == "Edit")
            {
                var id = Convert.ToInt16(lblTypeId.Value);
                var projectType = _db.ProjectTypes.Where(t => t.ProjectTypeId == id).FirstOrDefault();
                if (projectType != null)
                {
                    projectType.ProjectTypeName = NameTextBox.Text;
                    projectType.Description = DescriptionTextarea.InnerText;
                    _db.SaveChanges();
                    grdTypes.DataBind();
                }
            }
            else if (action == "Details")
                ModalPopup.Hide();

        }

        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        public IQueryable<VALE.Models.ProjectType> grdTypes_GetData()
        {
            return _db.ProjectTypes.OrderByDescending(t => t.CreationDate).AsQueryable();
        }

        public bool AllowManage(int projectTypeId)
        {
            if (projectTypeId == 1)
                return false;
            else
                return true;
        }
    }
}