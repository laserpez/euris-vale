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
        private BODReportActions _actions;
        private string _currentUser = HttpContext.Current.User.Identity.Name;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _db = new UserOperationsContext();
            if (Request.QueryString.HasKeys())
                _currentReportId = Convert.ToInt32(Request.QueryString["reportId"]);
            _actions = new BODReportActions();
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
            Button btnAddDocument = (Button)BODReportDetail.FindControl("btnAddDocument");
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") && !RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
            {
                btnAddDocument.Visible = false;
            }
        }

        public BODReport GetBODReport([QueryString("reportId")] int? reportId)
        {
            return _db.BODReports.First(r => r.BODReportId == reportId);
        }

        protected void BODReportDetail_DataBound(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            string result = db.BODReports.First(b => b.BODReportId == _currentReportId).Text;
            Label lblContent = (Label)BODReportDetail.FindControl("lblContent");
            lblContent.Text = result;
        }

        //------------------------------------------- File Uploader -------------------------------
        protected void btnAddDocument_Click(object sender, EventArgs e)
        {
            txtFileDescription.Text = "";
            LabelPopUpAddDocumentError.Visible = false;
            btnPopUpAddDocumentClose.Visible = true;
            lblInfoPopupAddDocument.Text = "Allega un documento";
            divDocunetPopupAddDocument.Visible = false;
            lblOperatioPopupAddDocument.Text = "UPLOAD";
            divFileUploderPopupAddDocument.Visible = true;
            divInfoPopupAddDocument.Visible = false;
            txtFileDescription.Enabled = true;
            validatorFileDescription.Enabled = true;
            ModalPopupAddDocument.Show();
        }

        public IQueryable<AttachedFileGridView> DocumentsGridView_GetData()
        {
            if (_actions != null)
                return CreateAttachedFileGridViewList(_actions.GetAttachments(_currentReportId).ToList()).AsQueryable();
            return null;
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView DocumentsGridView = (GridView)BODReportDetail.FindControl("DocumentsGridView");
            int id;
            switch (e.CommandName)
            {

                case "DOWNLOAD_FILE":
                    id = Convert.ToInt32(e.CommandArgument);
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "DELETE_FILE":
                    id = Convert.ToInt32(e.CommandArgument);
                    _actions.RemoveAttachment(id);
                    DocumentsGridView.PageIndex = 0;
                    DocumentsGridView.DataBind();
                    break;
                case "SHOW_VERSIONS":
                    var list = _actions.GetAttachments(_currentReportId).Where(f => f.FileName == e.CommandArgument.ToString()).OrderByDescending(f => f.CreationDate).AsQueryable();
                    ViewFileVersionsGridView.DataSource = list;
                    ViewFileVersionsGridView.DataBind();
                    lblFileNamePopupViewFileVersions.Text = e.CommandArgument.ToString();
                    ModalPopupViewFileVersions.Show();
                    break;
                case "UPDATE_FILE":
                    ShowUpdateFilePopUp(e.CommandArgument.ToString());
                    break;
                case "SHOW_DESC":
                    id = Convert.ToInt32(e.CommandArgument);
                    var file = GetFile(id);
                    if (file != null)
                        ShowInfoAttachedFile(file, false);
                    break;
                case "Page":
                    break;
            }
        }

        private AttachedFile GetFile(int fileId)
        {
            return _db.AttachedFiles.FirstOrDefault(f => f.AttachedFileID == fileId);
        }

        private void ShowInfoAttachedFile(AttachedFile file, bool isVersion)
        {
            btnPopUpAddDocumentClose.Visible = false;
            txtFileDescription.Text = file.FileDescription;
            LabelPopUpAddDocumentError.Visible = false;
            divInfoPopupAddDocument.Visible = true;
            divFileUploderPopupAddDocument.Visible = false;
            txtFileDescription.Enabled = false;
            validatorFileDescription.Enabled = false;
            lblInfoPopupAddDocument.Text = "Informazione del Documento";
            divDocunetPopupAddDocument.Visible = true;
            lblVersionPopupAddDocument.Text = file.Version.ToString();
            lblFileNamePopupAddDocument.Text = file.FileName + file.FileExtension;
            lblSizeFilePopupAddDocument.Text = (file.Size / (1024 * 1024)) > 0 ? (file.Size / (1024 * 1024)) + ","
                + (file.Size / (1024 * 1024)) + " MB" : (file.Size / 1024) + "," + (file.Size % 1024) + " KB";
            lblDatePopupAddDocument.Text = file.CreationDate.ToLongDateString();
            lblHourPopupAddDocument.Text = file.CreationDate.ToLongTimeString();
            if (isVersion)
                lblOperatioPopupAddDocument.Text = "INFO_VERSION";
            else
                lblOperatioPopupAddDocument.Text = "INFO_FILE";
            ModalPopupAddDocument.Show();
        }

        private void ShowUpdateFilePopUp(string fileName)
        {
            txtFileDescription.Text = "";
            LabelPopUpAddDocumentError.Visible = false;
            btnPopUpAddDocumentClose.Visible = true;
            divFileUploderPopupAddDocument.Visible = true;
            divInfoPopupAddDocument.Visible = false;
            txtFileDescription.Enabled = true;
            lblInfoPopupAddDocument.Text = "Aggiorna un documento";
            divDocunetPopupAddDocument.Visible = true;
            lblVersionPopupAddDocument.Text = GetNewAttachedFileVersion(fileName).ToString();
            lblFileNamePopupAddDocument.Text = fileName;
            validatorFileDescription.Enabled = true;
            lblOperatioPopupAddDocument.Text = "UPDATE";
            ModalPopupAddDocument.Show();
        }

        private int GetNewAttachedFileVersion(string attachedFileName)
        {
            int version = 0;
            var list = _actions.GetAttachments(_currentReportId).Where(f => f.FileName == attachedFileName);
            if (list.Count() > 0)
                version = list.Max(f => f.Version);
            return version + 1;
        }

        public bool AllowUpdateOrDelete(int attachedFileId)
        {
            var db = new UserOperationsContext();
            var attachedFile = db.AttachedFiles.First(a => a.AttachedFileID == attachedFileId);
            var relatedProject = attachedFile.RelatedProject;
            var currentUsername = HttpContext.Current.User.Identity.Name;
            if (attachedFile.Owner == currentUsername)
                return true;
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
                return true;
            if (relatedProject != null)
                if (relatedProject.OrganizerUserName == currentUsername)
                    return true;
            return false;
        }

        protected void btnPopUpAddDocument_Click(object sender, EventArgs e)
        {
            if (lblOperatioPopupAddDocument.Text == "INFO_FILE")
                ModalPopupAddDocument.Hide();
            else if (lblOperatioPopupAddDocument.Text == "INFO_VERSION")
                ModalPopupViewFileVersions.Show();
            else
            {
                GridView DocumentsGridView = (GridView)BODReportDetail.FindControl("DocumentsGridView");
                var attachedFile = new AttachedFile();
                var fileNames = FileUploadAddDocument.PostedFile.FileName.Split(new char[] { '/', '\\' });
                if (FileUploadAddDocument.HasFile)
                {
                    attachedFile.FileExtension = Path.GetExtension(FileUploadAddDocument.PostedFile.FileName);
                    if (lblOperatioPopupAddDocument.Text == "UPLOAD")
                    {
                        var fileName = fileNames[fileNames.Length - 1];
                        attachedFile.FileName = fileName.Substring(0, fileName.LastIndexOf('.'));
                    }
                    else
                    {
                        attachedFile.FileName = lblFileNamePopupAddDocument.Text;
                    }
                    attachedFile.Version = GetNewAttachedFileVersion(attachedFile.FileName);
                    attachedFile.FileDescription = txtFileDescription.Text;
                    attachedFile.FileData = FileUploadAddDocument.FileBytes;
                    attachedFile.Size = attachedFile.FileData.Length;
                    attachedFile.Owner = HttpContext.Current.User.Identity.Name;
                    attachedFile.CreationDate = DateTime.Now;
                    _actions.AddAttachment(_currentReportId, attachedFile);
                    DocumentsGridView.DataBind();
                }
                else
                {
                    LabelPopUpAddDocumentError.Text = "Selezionare il file prima di validare.";
                    LabelPopUpAddDocumentError.Visible = true;
                    ModalPopupAddDocument.Show();
                }
            }
        }

        protected void btnPopUpAddDocumentClose_Click(object sender, EventArgs e)
        {
            ModalPopupAddDocument.Hide();
        }

        private List<AttachedFileGridView> CreateAttachedFileGridViewList(List<AttachedFile> files)
        {
            List<AttachedFileGridView> litFiles = new List<AttachedFileGridView>();
            var orderGroups = from f in files
                              group f by f.FileName into g
                              select new { FileName = g.Key, Files = g };
            foreach (var g in orderGroups)
            {
                var file = g.Files.OrderByDescending(f => f.CreationDate).FirstOrDefault();
                AttachedFileGridView gridViewfile = new AttachedFileGridView
                {
                    AttachedFileID = file.AttachedFileID,
                    CreationDate = file.CreationDate,
                    FileDescription = file.FileDescription,
                    FileExtension = file.FileExtension,
                    FileName = file.FileName,
                    Size = file.Size,
                    Owner = file.Owner,
                    Version = file.Version,
                    VersionCount = g.Files.Count(),
                };
                litFiles.Add(gridViewfile);
            }
            return litFiles;
        }

        protected void ViewFileVersionsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView ViewFileVersionsGridView = (GridView)BODReportDetail.FindControl("ViewFileVersionsGridView");

            switch (e.CommandName)
            {
                case "DOWNLOAD_FILE":
                    int id = Convert.ToInt32(e.CommandArgument);
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "DELETE_FILE":
                    int idfile = Convert.ToInt32(e.CommandArgument);
                    _actions.RemoveAttachment(idfile);
                    ViewFileVersionsGridView.PageIndex = 0;
                    ViewFileVersionsGridView.DataBind();
                    break;
                case "SHOW_DESC":
                    id = Convert.ToInt32(e.CommandArgument);
                    var file = GetFile(id);
                    if (file != null)
                        ShowInfoAttachedFile(file, true);
                    break;
                case "Page":
                    break;
            }
        }

        protected void btnClosePopupViewFileVersions_Click(object sender, EventArgs e)
        {
            ModalPopupViewFileVersions.Hide();
        }


    }
}