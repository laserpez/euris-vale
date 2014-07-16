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

            FileUploader uploader = (FileUploader)ProjectDetail.FindControl("FileUploader");
            uploader.DataActions = new ProjectActions();
            uploader.DataId = _currentProjectId;

            if (!IsPostBack)
            {

                ShowHideControls();
                uploader.DataBind();
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

            var btnModify = (Button)ProjectDetail.FindControl("btnModifyProject");
            if ((aProject.OrganizerUserName == _currentUserName || User.IsInRole("Amministratore")) && aProject.Status != "Chiuso")
            {
                ((Button)ProjectDetail.FindControl("btnAddUsers")).Visible = true;
                btnModify.Visible = true;
            }
        }

        public string GetStatus(Activity anActivity)
        {
            string status;
            var activityActions = new ActivityActions();
                status = activityActions.GetStatus(anActivity);
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
            {
                var lstInterventions = _db.Interventions.Where(i => i.ProjectId == projectId).ToList();
                foreach (var intervention in lstInterventions)
                {
                    if (String.IsNullOrEmpty(intervention.InterventionText) && intervention.AttachedFiles.Count == 0)
                    {
                        _db.Interventions.Remove(intervention);
                        _db.SaveChanges();
                    }
                }
                return _db.Interventions.Where(i => i.ProjectId == projectId);
            }
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

                string result = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId).Description;
                Label lblContent = (Label)ProjectDetail.FindControl("lblContent");
                lblContent.Text = result;

                SetWorkOnProjectSection();
                SetManageProjectSection();
            }
        }

        private void SetWorkOnProjectSection()
        {
            var project = _db.Projects.First(p => p.ProjectId == _currentProjectId);
            var actions = new ProjectActions();
            Button btnAddIntervention = (Button)ProjectDetail.FindControl("btnAddIntervention");
            
            if (project.Status == "Aperto")
            {
                if (actions.IsUserRelated(_currentProjectId, _currentUserName))
                {
                    btnWorkOnThis.Enabled = true;
                    btnWorkOnThis.CssClass = "btn btn-success";
                    btnWorkOnThis.Text = "Stai lavorando";
                    btnAddIntervention.Enabled = true;
                    btnAddIntervention.CssClass = "btn btn-success btn-sm";
                    btnAddIntervention.Text = "Aggiungi conversazione";
                }
                else
                {
                    btnWorkOnThis.Enabled = true;
                    btnWorkOnThis.CssClass = "btn btn-info";
                    btnWorkOnThis.Text = "Lavora al progetto";
                    btnAddIntervention.Enabled = false;
                    btnAddIntervention.CssClass = "btn btn-success btn-sm disable";
                    btnAddIntervention.Text = "Non puoi aggiungere conversazioni";
                }
            }
            else
            {
                btnWorkOnThis.Enabled = false;
                btnWorkOnThis.CssClass = "btn btn-success btn-sm disable";
                btnWorkOnThis.Text = "Non puoi lavorare al progetto";
                btnAddIntervention.Visible = false;
            }
        }

        private void SetManageProjectSection()
        {
            var project = _db.Projects.First(p => p.ProjectId == _currentProjectId);
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
                var lblInfoOperation = (Label)ProjectDetail.FindControl("lblInfoOperation");
                lblInfoOperation.Text = "Solo il creatore può gestire lo stato del progetto";
            }
        }

        protected void CloseButton_Click(object sender, EventArgs e)
        {
            ModalPopupExtender popUp = (ModalPopupExtender)ProjectDetail.FindControl("ModalPopup");
            popUp.Hide();
        }
        protected void btnModifyStatusProject_Click(object sender, EventArgs e)
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
            var actions = new ProjectActions();
            actions.AddOrRemoveUserData(_currentProjectId, _currentUserName);
            grdUsers.DataBind();
            SetWorkOnProjectSection();
        }

        public List<ProjectType> GetTypes()
        {
            var db = new UserOperationsContext();
            return db.ProjectTypes.ToList();
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
            else if (e.CommandName == "DeleteIntervention")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var grdInterventions = (GridView)ProjectDetail.FindControl("grdInterventions");
                int interventionID = Convert.ToInt32(grdInterventions.DataKeys[index].Value.ToString());

                if (DeleteIntervention(interventionID))
                    grid.DataBind();
            }
        }

        private bool DeleteIntervention(int interventionID)
        {
            var anIntervention = _db.Interventions.FirstOrDefault(i => i.InterventionId == interventionID);
            var actions = new InterventionActions();

            if (anIntervention != null)
            {
                actions.RemoveAllAttachments(interventionID);
                _db.Interventions.Remove(anIntervention);
                _db.SaveChanges();
                return true;
            }
            else
                return false;
        }

        public bool ContainsDocuments(int interventionID)
        {
            var actions = new InterventionActions();
            return actions.GetAttachments(interventionID).Count > 0;
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

        protected void addUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + _currentProjectId + "&dataType=project&returnUrl=/MyVale/ProjectDetails?projectId=" + _currentProjectId);
        }
        
        protected void grdInterventions_RowCreated(object sender, GridViewRowEventArgs e)
        {
            var db = new UserOperationsContext();
            var grdInterventions = (GridView)sender;
            var dbData = new UserOperationsContext();
            DataControlField dataControlField = grdInterventions.Columns.Cast<DataControlField>().SingleOrDefault(x => x.HeaderText == "DELETE ROW");
            _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
            var currentProject = dbData.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            for (int i = 0; i < grdInterventions.Rows.Count; i++)
            {
                int interventionId = Convert.ToInt32(grdInterventions.DataKeys[i].Value);
                if (HttpContext.Current.User.IsInRole("Amministratore") || currentProject.OrganizerUserName == _currentUserName || db.Interventions.Where(o => o.InterventionId == interventionId).FirstOrDefault().Creator.UserName == _currentUserName)
                {
                    dataControlField.Visible = true;
                    Button delIntervention = (Button)grdInterventions.Rows[i].FindControl("btnDeleteIntervention");
                    delIntervention.Visible = true;
                }


            }
                if (HttpContext.Current.User.IsInRole("Amministratore") || currentProject.OrganizerUserName == _currentUserName)
                {
                    if (dataControlField != null)
                        dataControlField.Visible = true;
                }
        }
        
        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ModalPopupProject.Hide();
        }

        protected void btnModifyProject_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var project = db.Projects.Where(o => o.ProjectId == _currentProjectId).FirstOrDefault();
            btnConfirmModify.Text = "Modifica";
            btnClosePopUpButton.Visible = true;
            txtName.Enabled = true;
            txtName.CssClass = "form-control";
            txtName.Text = project.ProjectName;
            txtDescription.Text = project.Description;
            ddlSelectType.SelectedValue = project.Type;
            txtStartDate.Text = project.CreationDate.ToShortDateString();
            chkPublic.Checked = project.Public;
            ModalPopupProject.Show();
        }

        protected void btnConfirmModify_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var project = db.Projects.Where(o => o.ProjectId == _currentProjectId).FirstOrDefault();
            project.ProjectName = txtName.Text;
            project.Description = txtDescription.Text;
            project.CreationDate = Convert.ToDateTime(txtStartDate.Text);
            project.LastModified = DateTime.Now;
            project.Public = chkPublic.Checked;
            project.Type = ddlSelectType.SelectedValue;
            db.SaveChanges();
            Response.Redirect("~/MyVale/ProjectDetails.aspx?projectId=" + _currentProjectId);
        }

        
       

        public IQueryable<Project> GetProjects()
        {
            var _db = new UserOperationsContext();
            return _db.Projects.Where(pr => pr.Status != "Chiuso" && pr.ProjectId != _currentProjectId).OrderBy(p => p.ProjectName);
        }

        //++++++++++++++++++++++++++RelatedProject+++++++++++++++++++++++++++++++++
        protected void btnDeleteRelatedProject_Click(object sender, EventArgs e)
        {
            ProjectActions projectActions = new ProjectActions();
            projectActions.DeletRelatedProject(_currentProjectId);
            UpdateRelatedProjectView();
        }

        protected void btnAddRelatedProject_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Show();
        }

        public IQueryable<Project> GetProjectsList()
        {
            ProjectActions projectActions = new ProjectActions();
            return projectActions.GetCompatibleProjects(_currentProjectId).AsQueryable();
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Hide();
        }

        protected void btnChooseProject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            var projectId = Convert.ToInt32(btn.CommandArgument);
            var project = _db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            if (project != null)
            {
                var currentProject = _db.Projects.First(a => a.ProjectId == _currentProjectId);
                currentProject.RelatedProject = project;
                _db.SaveChanges();
                UpdateRelatedProjectView();
                Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
            }

        }

        //Devono essere gestiti i vincoli per la modifica : amministratore/utente normale/creatore dell'attività
        public IQueryable<Project> GetRelatedProjectList([QueryString("projectId")] int? PprojectId)
        {
            ModalPopupListProject.Hide();
            if (PprojectId.HasValue)
            {
                Button btnDeleteRelatedProject = (Button)ProjectDetail.FindControl("btnDeleteRelatedProject");
                Button btnAddRelatedProject = (Button)ProjectDetail.FindControl("btnAddRelatedProject");
                var currentProject = _db.Projects.First(a => a.ProjectId == _currentProjectId);
                var project = currentProject.RelatedProject;
                if (project != null)
                {
                    btnDeleteRelatedProject.Visible = true;
                    btnAddRelatedProject.Visible = false;
                    var list = new List<Project> { project };
                    return list.AsQueryable();
                }
                else
                {
                    btnDeleteRelatedProject.Visible = false;
                    btnAddRelatedProject.Visible = true;
                }
            }
            return null;
        }

        public string GetDescription(string description)
        {
            string result;
            if (!String.IsNullOrEmpty(description))
            {
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(description);
                description = doc.DocumentNode.InnerText;
                result = doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
            }
            else
                result = "Nessun commento inserito";

            return result;
        }

        public List<Project> GetProjectHierarchyUp() 
        {
            ProjectActions projectActions = new ProjectActions();
            var list = projectActions.getHierarchyUp(_currentProjectId);
            list.Reverse();
            return list;
        }

        public List<Project> GetProjectForHierarchy()
        {
            var project = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            if (project != null)
            {
                return new List<Project> { project};
            }
            return null;
        }

        public List<Project> GetProjectHierarchyDown()
        {
            ProjectActions projectActions = new ProjectActions();
            return projectActions.getHierarchyDown(_currentProjectId);
        }

        private void UpdateRelatedProjectView()
        {
            ListView listViewRelatedProject = (ListView)ProjectDetail.FindControl("listViewRelatedProject");
            listViewRelatedProject.DataBind();
            GridView grdRelatedProject = (GridView)ProjectDetail.FindControl("grdRelatedProject");
            grdRelatedProject.DataBind();
        }
      
    }
}