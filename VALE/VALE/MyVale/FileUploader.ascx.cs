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
            var fileName = FileUpload.PostedFile.FileName.Split(new char[] { '/', '\\' });
            if (FileUpload.HasFile)
            {
                attachedFile.FileName = fileName[fileName.Length - 1];
                attachedFile.FileDescription = txtFileDescription.Value;
                attachedFile.FileExtension = Path.GetExtension(FileUpload.PostedFile.FileName);
                attachedFile.FileData = FileUpload.FileBytes;
                attachedFile.Owner = HttpContext.Current.User.Identity.Name;
                attachedFile.CreationDate = DateTime.Now;
                DataActions.AddAttachment(DataId, attachedFile);
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
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "Cancella":
                    DataActions.RemoveAttachment(id);
                    DocumentsGridView.PageIndex = 0;
                    DocumentsGridView.DataBind();
                    break;
            }
        }

        public bool AllowDelete(int attachedFileId)
        {
            var db = new UserOperationsContext();
            var attachedFile = db.AttachedFiles.First(a => a.AttachedFileID == attachedFileId);
            var relatedProject = attachedFile.RelatedProject;
            var relatedEvent = attachedFile.RelatedEvent;
            var relatedIntervention = attachedFile.RelatedIntervention;
            var currentUsername = HttpContext.Current.User.Identity.Name;
            if (attachedFile.Owner == currentUsername)
                return true;
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
                return true;
            if (relatedProject != null)
                if (relatedProject.OrganizerUserName == currentUsername)
                    return true;
            if (relatedEvent != null)
                if (relatedEvent.OrganizerUserName == currentUsername)
                    return true;
            if (relatedIntervention != null)
                if (relatedIntervention.CreatorUserName == currentUsername)
                    return true;
            return false;
        }
    }
}