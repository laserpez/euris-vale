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
        public IActions DataActions
        {
            get { return (IActions)ViewState["dataActions"]; }
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

        //public string AllowDelete(AttachedFile attachedFile)
        //{
        //    //if (attachedFile.Owner == _currentUserName)
        //    //    return "";
        //    //if (HttpContext.Current.User.IsInRole("Amministratore"))
        //    //    return "";
        //    //var currentProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
        //    //if (currentProject != null)
        //    //    if (currentProject.OrganizerUserName == _currentUserName)
        //    //        return "";
        //    //return "style";

        //}
    }
}