using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.MyVale.BOD
{
    public partial class VALEDocuments : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") && !RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
            {
                btnAddDocument.Visible = false;
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "DocumentiAssociazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina VALEDocuments.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public int DataId
        {
            get { return (int)ViewState["datavaleId"]; }
            set { ViewState["datavaleId"] = value; }
        }

        public bool AllowUpload { get; set; }

        public IQueryable<ValeFile> DocumentsGridView_GetData()
        {
            var db = new UserOperationsContext();
            return db.VALEFiles.OrderBy(v => v.ValeFileID).AsQueryable();
        }

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var db = new UserOperationsContext();
            int id = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "DOWNLOAD":
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id+"&page=VALEDocuments");
                    break;
                case "Cancella":
                    var elem = db.VALEFiles.Where(o => o.ValeFileID == id).FirstOrDefault();
                    db.VALEFiles.Remove(elem);
                    db.SaveChanges();
                    DocumentsGridView.PageIndex = 0;
                    DocumentsGridView.DataBind();
                    break;
                case "Page":
                    break;
            }
        }

        public bool AllowDelete(int attachedFileId)
        {
            var db = new UserOperationsContext();
            var attachedFile = db.VALEFiles.First(a => a.ValeFileID == attachedFileId);
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
                return true;
            return false;
        }

        protected void btnPopUpAddDocument_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var attachedFile = new ValeFile();
            var fileName = FileUploadAddDocument.PostedFile.FileName.Split(new char[] { '/', '\\' });
            if (FileUploadAddDocument.HasFile)
            {
                attachedFile.FileName = fileName[fileName.Length - 1];
                attachedFile.FileDescription = txtFileDescription.Text;
                attachedFile.FileExtension = Path.GetExtension(FileUploadAddDocument.PostedFile.FileName);
                attachedFile.FileData = FileUploadAddDocument.FileBytes;
                txtFileDescription.Text = "";
                db.VALEFiles.Add(attachedFile);
                db.SaveChanges();
                DocumentsGridView.DataBind();
            }
        }

        protected void btnPopUpAddDocumentClose_Click(object sender, EventArgs e)
        {
            ModalPopupAddDocument.Hide();
        }

        protected void btnAddDocument_Click(object sender, EventArgs e)
        {
            ModalPopupAddDocument.Show();
        }
    }
}