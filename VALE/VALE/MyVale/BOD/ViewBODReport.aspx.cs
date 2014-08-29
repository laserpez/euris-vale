using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale.BOD
{
    public partial class ViewBODReport : Page
    {
        private int _currentReportId;
        private UserOperationsContext _db;
        private string _currentUser = HttpContext.Current.User.Identity.Name;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _db = new UserOperationsContext();
            if (Request.QueryString.HasKeys())
                _currentReportId = Convert.ToInt32(Request.QueryString["reportId"]);

            ShowFileUploader();
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Consiglio"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ViewBODReport.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        private void ShowFileUploader()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") && !RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
            {
                FooterDocuments.Visible = false;
            }
        }

        public BODReport GetBODReport([QueryString("reportId")] int? reportId)
        {
            return _db.BODReports.First(r => r.BODReportId == reportId);
        }

        public int DataId
        {
            get { return (int)ViewState["datavaleId"]; }
            set { ViewState["datavaleId"] = value; }
        }

        public bool AllowUpload { get; set; }

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var attachedFile = new AttachedFile();
            var fileName = FileUpload.PostedFile.FileName.Split(new char[] { '/', '\\' });
            if (FileUpload.HasFile)
            {
                attachedFile.BODReportId = _currentReportId;
                attachedFile.FileName = fileName[fileName.Length - 1];
                attachedFile.FileDescription = txtFileDescription.Text;
                attachedFile.FileExtension = Path.GetExtension(FileUpload.PostedFile.FileName);
                attachedFile.FileData = FileUpload.FileBytes;
                attachedFile.CreationDate = DateTime.Now;
                txtFileDescription.Text = "";
                db.AttachedFiles.Add(attachedFile);
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
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "Cancella":
                    var actions = new BODReportActions();
                    actions.RemoveAttachment(id);
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
            var attachedFile = db.AttachedFiles.First(a => a.AttachedFileID == attachedFileId);
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
                return true;
            return false;
        }

        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            var actions = new BODReportActions();
            var list = actions.GetAttachments(_currentReportId);
            return list.AsQueryable();
        }

        protected void BODReportDetail_DataBound(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            string result = db.BODReports.First(b => b.BODReportId == _currentReportId).Text;
            Label lblContent = (Label)BODReportDetail.FindControl("lblContent");
            lblContent.Text = result;
        }
    }
}