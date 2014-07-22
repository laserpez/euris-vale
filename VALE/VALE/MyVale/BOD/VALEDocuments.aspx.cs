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
            if (!HttpContext.Current.User.IsInRole("Amministratore") && !HttpContext.Current.User.IsInRole("Membro del consiglio"))
            {
                FooterDocuments.Visible = false;
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
            var db = new UserOperationsContext();
            var attachedFile = new ValeFile();
            var fileName = FileUpload.PostedFile.FileName.Split(new char[]{'/','\\'});
            if (FileUpload.HasFile)
            {
                attachedFile.FileName = fileName[fileName.Length - 1];
                attachedFile.FileDescription = txtFileDescription.Value;
                attachedFile.FileExtension = Path.GetExtension(FileUpload.PostedFile.FileName);
                attachedFile.FileData = FileUpload.FileBytes;
                txtFileDescription.Value = "";
                db.VALEFiles.Add(attachedFile);
                db.SaveChanges();
                DocumentsGridView.DataBind();
            }
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
            }
        }

        public bool AllowDelete(int attachedFileId)
        {
            var db = new UserOperationsContext();
            var attachedFile = db.VALEFiles.First(a => a.ValeFileID == attachedFileId);
            if (HttpContext.Current.User.IsInRole("Amministratore") || HttpContext.Current.User.IsInRole("Membro del consiglio"))
                return true;
            return false;
        }
    }
}