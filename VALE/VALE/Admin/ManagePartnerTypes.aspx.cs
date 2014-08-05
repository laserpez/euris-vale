using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManagePartnerTypes : System.Web.UI.Page
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
                case "Page":
                    break;
            }
        }

        private void DeleteType(int typeId)
        {
            var partnerType = _db.PartnerTypes.Where(p => p.PartnerTypeId == typeId).FirstOrDefault();
            if (partnerType != null)
            {
                _db.PartnerTypes.Remove(partnerType);
                _db.SaveChanges();
                grdTypes.PageIndex = 0;
                grdTypes.DataBind();
            }
        }

        private void EditType(int typeId)
        {
            var partnerType = _db.PartnerTypes.Where(p => p.PartnerTypeId == typeId).FirstOrDefault();
            if (partnerType != null)
            {
                btnClosePopUpButton.Visible = true;
                btnOkButton.Text = "Salva";
                NameTextBox.Enabled = true;
                NameTextBox.CssClass = "form-control input-sm";
                DescriptionTextarea.Disabled = false;
                NameTextBox.Text = partnerType.PartnerTypeName;
                DescriptionTextarea.InnerText = partnerType.Description;
                lblTypeAction.Text = "Edit";
                lblTypeId.Value = typeId.ToString();
                ModalPopup.Show();
            }
        }

        private void ShowType(int typeId)
        {
            var partnerType = _db.PartnerTypes.Where(p => p.PartnerTypeId == typeId).FirstOrDefault();
            if (partnerType != null)
            {
                btnClosePopUpButton.Visible = false;
                btnOkButton.Text = "Chiudi";
                NameTextBox.Enabled = false;
                NameTextBox.CssClass = "form-control input-sm disabled";
                DescriptionTextarea.Disabled = true;
                NameTextBox.Text = partnerType.PartnerTypeName;
                DescriptionTextarea.InnerText = partnerType.Description;
                lblTypeAction.Text = "Details";
                ModalPopup.Show();
            }
        }


        protected void btnOkButton_Click(object sender, EventArgs e)
        {
            var action = lblTypeAction.Text;
            if (action == "Add")
            {
                PartnerType partnerType = new PartnerType();
                partnerType.CreationDate = DateTime.Now;
                partnerType.PartnerTypeName = NameTextBox.Text;
                partnerType.Description = DescriptionTextarea.InnerText;
                _db.PartnerTypes.Add(partnerType);
                _db.SaveChanges();
                grdTypes.DataBind();
            }
            else if (action == "Edit")
            {
                var id = Convert.ToInt16(lblTypeId.Value);
                var partnerType = _db.PartnerTypes.Where(t => t.PartnerTypeId == id).FirstOrDefault();
                if (partnerType != null)
                {
                    partnerType.PartnerTypeName = NameTextBox.Text;
                    partnerType.Description = DescriptionTextarea.InnerText;
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

        public IQueryable<VALE.Models.PartnerType> grdTypes_GetData()
        {
            return _db.PartnerTypes.OrderByDescending(t => t.CreationDate).AsQueryable();
        }

        public bool AllowManage(int partnerTypeId)
        {
            if (partnerTypeId == 1)
                return false;
            else
                return true;
        }
    }
}