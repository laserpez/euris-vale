using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class FileUploader : System.Web.UI.UserControl
    {
        public IFileActions DataActions
        {
            get { return (IFileActions)ViewState["dataActions"]; }
            set { ViewState["dataActions"] = value; }
        }
        public int DataId
        {
            get { return (int)ViewState["dataId"]; }
            set { ViewState["dataId"] = value; }
        }

        public bool AllowUpload { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            var attachedFile = new AttachedFile();
            if (FileUpload.HasFile)
            {
                attachedFile.FileName = FileUpload.PostedFile.FileName;
                attachedFile.FileDescription = txtFileDescription.Text;
                attachedFile.FileExtension = Path.GetExtension(FileUpload.PostedFile.FileName);
                attachedFile.FileData = FileUpload.FileBytes;
                attachedFile.Owner = HttpContext.Current.User.Identity.Name;
                attachedFile.CreationDate = DateTime.Now;
                DataActions.AddAttachment(DataId, attachedFile);
                txtFileDescription.Text = "";
                DocumentsGridView.DataBind();
            }
        }

        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            if (DataActions != null)
                return DataActions.GetAttachments(DataId).AsQueryable();
            return null;
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "DOWNLOAD":
                default:
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "Cancella":
                    DataActions.RemoveAttachment(id);
                    DocumentsGridView.DataBind();
                    break;
            }
        }

        public bool AllowDelete(int attachedFileId)
        {
            var db = new UserOperationsContext();
            var attachedFile = db.AttachedFiles.First(a => a.AttachedFileID == attachedFileId);
            var relatedPrj = attachedFile.RelatedProject;
            var currentUsername = HttpContext.Current.User.Identity.Name;
            if (attachedFile.Owner == currentUsername)
                return true;
            if (HttpContext.Current.User.IsInRole("Amministratore"))
                return true;
            if (relatedPrj != null)
                if (relatedPrj.OrganizerUserName == currentUsername)
                    return true;
            return false;
        }
    }
}