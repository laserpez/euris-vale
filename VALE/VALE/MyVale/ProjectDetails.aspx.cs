using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using VALE.Models;
using VALE.Logic;
using AjaxControlToolkit;

namespace VALE.MyVale
{
    public partial class ProjectDetails : System.Web.UI.Page
    {
        private int _currentProjectId;
        private string _currentUserName;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUserName = User.Identity.GetUserName();
            
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
            if (!IsPostBack)
            {
                DataBindControls();
                ShowHideControls();
            }
        }

        private void ShowHideControls()
        {
            var _db = new UserOperationsContext();
            var aProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            if (aProject.Status == "Chiuso")
            {
                var btnAddEvent = (Button)ProjectDetail.FindControl("btnAddEvent");
                btnAddEvent.Visible = false;

                var btnAddActivity = (Button)ProjectDetail.FindControl("btnAddActivity");
                btnAddActivity.Visible = false;
            }
        }

        private void DataBindControls()
        {
            if (_currentProjectId != 0)
            {
                var currentProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);

                if (currentProject != null)
                {
                    var isPublic = currentProject.Public;
                    var checkBox = (CheckBox)ProjectDetail.FindControl("checkboxPublic");
                    if (checkBox != null)
                    {
                        if (isPublic == true)
                            checkBox.Checked = true;
                        else
                            checkBox.Checked = false;
                    }
                    if (currentProject.Status == "Chiuso")
                        checkBox.Enabled = false;
                    else
                        checkBox.Enabled = true;
                }
            }
        }

        public string GetStatus(Activity anActivity)
        {
            string status;
            using (var activityActions = new ActivityActions())
            {
                status = activityActions.GetStatus(anActivity);
            }
            return status;
        }

        public Project GetProject([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
                return _db.Projects.Where(a => a.ProjectId == projectId).First();
            else
                return null;
        }

        public Project GetRelatedProject([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
                return _db.Projects.Where(a => a.ProjectId == projectId).Select(p => p.RelatedProject).FirstOrDefault();
            else
                return null;
        }

        public IQueryable<Event> GetRelatedEvents([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
                return _db.Projects.First(p => p.ProjectId == projectId).Events.AsQueryable();
            else
                return null;
        }

        public IQueryable<Activity> GetRelatedActivities([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
                return _db.Projects.First(p => p.ProjectId == projectId).Activities.AsQueryable();
            else
                return null;
        }

        public IQueryable<UserData> GetRelatedUsers([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
                return _db.Projects.Where(a => a.ProjectId == projectId).FirstOrDefault().InvolvedUsers.AsQueryable();
            else
                return null;
        }

        public IQueryable<Intervention> GetInterventions([QueryString("projectId")] int? projectId)
        {

            if (projectId.HasValue)
                return _db.Interventions.Where(i => i.ProjectId == projectId);
            else
                return null;
        }

        protected void btnSuspendProject_Click(object sender, EventArgs e)
        {
            var project = _db.Projects.First(p => p.ProjectId == _currentProjectId);
            Label label = (Label)ProjectDetail.FindControl("lblInfoOperation");
            if (project.Status == "Sospeso")
                label.Text = "RIPRENDI";
            else
                label.Text = "SOSPENDI";
            ModalPopupExtender popUp = (ModalPopupExtender)ProjectDetail.FindControl("ModalPopup");
            popUp.Show();
        }

        protected void btnCloseProject_Click(object sender, EventArgs e)
        {
            Label label = (Label)ProjectDetail.FindControl("lblInfoOperation");
            label.Text = "CHIUDI";
            ModalPopupExtender popUp = (ModalPopupExtender)ProjectDetail.FindControl("ModalPopup");
            popUp.Show();
        }

        protected void ProjectDetail_DataBound(object sender, EventArgs e)
        {
            if (_currentProjectId != 0)
            {
                var project = _db.Projects.First(p => p.ProjectId == _currentProjectId);
                SetWorkOnProjectSection(project);
                SetManageProjectSection(project);
            }
        }

        private void SetWorkOnProjectSection(Project project)
        {
            Button btnWork = (Button)ProjectDetail.FindControl("btnWorkOnThis");
            Button btnAddIntervention = (Button)ProjectDetail.FindControl("btnAddIntervention");
            
            if (project.Status == "Aperto")
            {
                if (project.InvolvedUsers.Select(u => u.UserName).Contains(_currentUserName))
                {
                    btnWork.Enabled = true;
                    btnWork.CssClass = "btn btn-success";
                    btnWork.Text = "Stai lavorando";
                    btnAddIntervention.Enabled = true;
                    btnAddIntervention.CssClass = "btn btn-info";
                    btnAddIntervention.Text = "Aggiungi intervento";
                }
                else
                {
                    btnWork.Enabled = true;
                    btnWork.CssClass = "btn btn-info";
                    btnWork.Text = "Lavora al progetto";
                    btnAddIntervention.Enabled = false;
                    btnAddIntervention.CssClass = "btn btn-info disable";
                    btnAddIntervention.Text = "Non puoi aggiungere interventi";
                }
            }
            else
            {
                btnWork.Enabled = false;
                btnWork.CssClass = "btn btn-info disable";
                btnWork.Text = "Non puoi lavorare al progetto";
                btnAddIntervention.Visible = false;
            }
        }

        private void SetManageProjectSection(Project project)
        {
            Button btnSuspend = (Button)ProjectDetail.FindControl("btnSuspendProject");
            Button btnClose = (Button)ProjectDetail.FindControl("btnCloseProject");
            Label lblInfo = (Label)ProjectDetail.FindControl("lblInfoManage");
            if (project.OrganizerUserName == _currentUserName || User.IsInRole("Amministratore"))
            {
                if (project.Status == "Aperto")
                {
                    btnSuspend.Text = "Sospendi progetto";
                    btnSuspend.Enabled = true;
                    btnSuspend.CssClass = "btn btn-warning";
                    btnClose.Text = "Chiudi progetto";
                    btnClose.Enabled = true;
                    btnClose.CssClass = "btn btn-danger";
                }
                else if (project.Status == "Sospeso")
                {
                    btnSuspend.Text = "Riprendi progetto";
                    btnSuspend.Enabled = true;
                    btnSuspend.CssClass = "btn btn-warning";
                    btnClose.Text = "Chiudi progetto";
                    btnClose.Enabled = true;
                    btnClose.CssClass = "btn btn-danger";
                }
                else
                {
                    btnSuspend.Text = "Il progetto è chiuso";
                    btnSuspend.Enabled = false;
                    btnSuspend.CssClass = "btn btn-warning disabled";
                    btnClose.Text = "Il progetto è chiuso";
                    btnClose.Enabled = false;
                    btnClose.CssClass = "btn btn-danger disabled";
                }
            }
            else
            {
                btnSuspend.Visible = false;
                btnClose.Visible = false;
                lblInfo.Text = "Solo il creatore può gestire lo stato del progetto";
            }
        }

        protected void CloseButton_Click(object sender, EventArgs e)
        {
            ModalPopupExtender popUp = (ModalPopupExtender)ProjectDetail.FindControl("ModalPopup");
            popUp.Hide();
        }
        protected void btnModifyProject_Click(object sender, EventArgs e)
        {
            
            Label label = (Label)ProjectDetail.FindControl("lblInfoOperation");
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var passTextbox = (TextBox)ProjectDetail.FindControl("Password");
            var password = passTextbox.Text;
            if (!string.IsNullOrEmpty(password))
            {
                ApplicationUser user = manager.Find(_currentUserName, password);
                if (user != null)
                {
                    var db = new UserOperationsContext();
                    var project = db.Projects.First(p => p.ProjectId == _currentProjectId);

                    switch (label.Text)
                    {
                        case "SOSPENDI":
                            project.Status = "Sospeso";
                            break;
                        case "CHIUDI":
                            project.Status = "Chiuso";
                            break;
                        case "RIPRENDI":
                            project.Status = "Aperto";
                            break;
                    }
                    db.SaveChanges();
                    Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
                }
            }
        }

        protected void btnWorkOnThis_Click(object sender, EventArgs e)
        {
            GridView grdUsers = (GridView)ProjectDetail.FindControl("lstUsers");
            var db = new UserOperationsContext();
            var project = db.Projects.First(p => p.ProjectId == _currentProjectId);
            var user = db.UsersData.First(u => u.UserName == _currentUserName);
            using (var actions = new ProjectActions())
            {
                actions.AddOrRemoveUser(project, user);
                db.SaveChanges();
                grdUsers.DataBind();
                SetWorkOnProjectSection(project);
            }
        }

        protected void btnAddIntervention_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/CreateIntervention?projectId=" + _currentProjectId);
        }

        protected void grdInterventions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            if (e.CommandName == "ViewIntervention")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var grdInterventions = (GridView)ProjectDetail.FindControl("grdInterventions");
                string interventionID = grdInterventions.DataKeys[index].Value.ToString();
                Response.Redirect("/MyVale/InterventionDetails?interventionId=" + interventionID);
            }
        }

        public bool ContainsDocuments(string path)
        {
            DirectoryInfo dir = new DirectoryInfo(Server.MapPath(path));
            return dir.GetFiles().Count() > 0;
        }

        protected void btnAddActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/Create/ActivityCreate?projectId=" + _currentProjectId);
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/Create/EventCreate?projectId=" + _currentProjectId);
        }

        protected void checkboxPublic_CheckedChanged(object sender, EventArgs e)
        {
            var currentProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            if (currentProject != null)
            {
                var checbox = (CheckBox)sender;
                currentProject.Public = checbox.Checked;
                _db.SaveChanges();
            }

        }

        //*****************************PARTE DI UPLOAD FILE************************************************

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            AttachedFile attachedFile = new AttachedFile();
            FileUpload fileUpload = (FileUpload)ProjectDetail.FindControl("FileUpload");
            GridView documentsGridView = (GridView)ProjectDetail.FindControl("DocumentsGridView");
            TextBox txtFileDescription = (TextBox)ProjectDetail.FindControl("txtFileDescription");
            if (fileUpload.HasFile)
            {
                attachedFile.FileName = fileUpload.PostedFile.FileName;
                attachedFile.FileDescription = txtFileDescription.Text;
                attachedFile.FileExtension = Path.GetExtension(fileUpload.PostedFile.FileName);
                attachedFile.FileData = fileUpload.FileBytes;
                attachedFile.Owner = User.Identity.Name;
                attachedFile.CreationDate = DateTime.Now;
                 var currentProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
                 if (currentProject != null)
                 {
                     currentProject.AttachedFiles.Add(attachedFile);
                 }
                _db.SaveChanges();
                txtFileDescription.Text = "";
                documentsGridView.DataBind();
            }
        }

        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            var currentProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            if (currentProject != null)
                return currentProject.AttachedFiles.AsQueryable();
            return null;
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView documentsGridView = (GridView)ProjectDetail.FindControl("DocumentsGridView");
            GridView grid = (GridView)sender;
            int id = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "DOWNLOAD":
                default:
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "Cancella":
                    var attachedFile = _db.AttachedFiles.FirstOrDefault(f => f.AttachedFileID == id);
                    if (attachedFile != null)
                    {
                        _db.AttachedFiles.Remove(attachedFile);
                        _db.SaveChanges();
                        documentsGridView.DataBind();
                    }
                    break;
            }
        }

        public string AllowDelete(AttachedFile attachedFile) 
        {
            if (attachedFile.Owner == _currentUserName)
                return "";
            if(HttpContext.Current.User.IsInRole("Amministratore"))
                return "";
            var currentProject = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            if (currentProject != null)
                if (currentProject.OrganizerUserName == _currentUserName)
                    return "";
            return "style";
        }

        //*****************************PARTE DI UPLOAD FILE************************************************
    }
}