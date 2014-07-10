using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManageActivityTypes : System.Web.UI.Page
    {
        UserOperationsContext _db = new UserOperationsContext();

        protected void Page_Load(object sender, EventArgs e)
        {

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
            }
        }

        

        private void DeleteType(int typeId)
        {
            var activityType = _db.ActivityTypes.Where(a => a.ActivityTypeId == typeId).FirstOrDefault();
            if (activityType != null)
            {
                _db.ActivityTypes.Remove(activityType);
                _db.SaveChanges();
                grdTypes.DataBind();
            }
        }

        private void EditType(int typeId)
        {
            var activityType = _db.ActivityTypes.Where(a => a.ActivityTypeId == typeId).FirstOrDefault();
            if (activityType != null)
            {
                btnClosePopUpButton.Visible = true;
                btnOkButton.Text = "Salva";
                NameTextBox.Enabled = true;
                NameTextBox.CssClass = "form-control input-sm";
                DescriptionTextarea.Disabled = false;
                NameTextBox.Text = activityType.ActivityTypeName;
                DescriptionTextarea.InnerText = activityType.Description;
                lblTypeAction.Text = "Edit";
                lblTypeId.Value = typeId.ToString();
                ModalPopup.Show();
            }
        }

        private void ShowType(int typeId)
        {
            var activityType = _db.ActivityTypes.Where(a => a.ActivityTypeId == typeId).FirstOrDefault();
            if (activityType != null)
            {
                btnClosePopUpButton.Visible = false;
                btnOkButton.Text = "Chiudi";
                NameTextBox.Enabled = false;
                NameTextBox.CssClass = "form-control input-sm disabled";
                DescriptionTextarea.Disabled = true;
                NameTextBox.Text = activityType.ActivityTypeName;
                DescriptionTextarea.InnerText = activityType.Description;
                lblTypeAction.Text = "Details";
                ModalPopup.Show();
            }
        }


        protected void btnOkButton_Click(object sender, EventArgs e)
        {
            var action = lblTypeAction.Text;
            if (action == "Add")
            {
                ActivityType activityType = new ActivityType();
                activityType.CreationDate = DateTime.Now;
                activityType.ActivityTypeName = NameTextBox.Text;
                activityType.Description = DescriptionTextarea.InnerText;
                _db.ActivityTypes.Add(activityType);
                _db.SaveChanges();
                grdTypes.DataBind();
            }
            else if (action == "Edit")
            {
                var id = Convert.ToInt16(lblTypeId.Value);
                var activityType = _db.ActivityTypes.Where(t => t.ActivityTypeId == id).FirstOrDefault();
                if (activityType != null)
                {
                    activityType.ActivityTypeName = NameTextBox.Text;
                    activityType.Description = DescriptionTextarea.InnerText;
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

        public IQueryable<VALE.Models.ActivityType> grdTypes_GetData()
        {
            return _db.ActivityTypes.AsQueryable();
        }

        public bool AllowManage(int activityTypeId)
        {
            if (activityTypeId == 1)
                return false;
            else
                return true;
        }
      
    }
}