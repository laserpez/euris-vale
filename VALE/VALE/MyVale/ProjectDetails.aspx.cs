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
    public partial class ProjectDetails : Page
    {
        private int _currentProjectId;
        private string _currentUserName;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            _db = new UserOperationsContext();
            _currentUserName = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());

            FileUploader uploader = (FileUploader)ProjectDetail.FindControl("FileUploader");
            uploader.DataActions = new ProjectActions();
            uploader.DataId = _currentProjectId;
            PopulateProjectTreeView();
            if (!IsPostBack)
            {
                if (Request.QueryString["From"] != null)
                    Session["ProjectDetailsRequestFrom"] = Request.QueryString["From"];
                ShowHideControls();
                uploader.DataBind();
            }
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "Progetti"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ProjectDetails.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
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
            project.LastModified = DateTime.Now;
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
                    btnAddIntervention.CssClass = "btn btn-success btn-xs";
                    btnAddIntervention.Text = "Aggiungi conversazione";

                    var btnAddEvent = (Button)ProjectDetail.FindControl("btnAddEvent");
                    btnAddEvent.Enabled = true;
                    btnAddEvent.CssClass = "btn btn-success btn-xs";
                    btnAddEvent.Text = "Aggiungi evento";

                    var btnAddActivity = (Button)ProjectDetail.FindControl("btnAddActivity");
                    btnAddActivity.Enabled = true;
                    btnAddActivity.CssClass = "btn btn-success btn-xs";
                    btnAddActivity.Text = "Aggiungi attività";
                }
                else
                {
                    btnWorkOnThis.Enabled = true;
                    btnWorkOnThis.CssClass = "btn btn-info";
                    btnWorkOnThis.Text = "Lavora al progetto";
                    btnAddIntervention.Enabled = false;
                    btnAddIntervention.CssClass = "btn btn-success btn-xs disable";
                    btnAddIntervention.Text = "Non puoi aggiungere conversazioni";

                    var btnAddEvent = (Button)ProjectDetail.FindControl("btnAddEvent");
                    btnAddEvent.Enabled = false;
                    btnAddEvent.CssClass = "btn btn-success btn-xs disable";
                    btnAddEvent.Text = "Non puoi aggiungere eventi";

                    var btnAddActivity = (Button)ProjectDetail.FindControl("btnAddActivity");
                    btnAddActivity.Enabled = false;
                    btnAddActivity.CssClass = "btn btn-success btn-xs disable";
                    btnAddActivity.Text = "Non puoi aggiungere attività";
                }
            }
            else
            {
                btnWorkOnThis.Enabled = false;
                btnWorkOnThis.CssClass = "btn btn-success disable";
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

                    project.LastModified = DateTime.Now;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(_currentProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);

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
                Response.Redirect("/MyVale/InterventionDetails?interventionId=" + interventionID + "&From=~/MyVale/ProjectDetails?projectId=" + _currentProjectId);
            }
            else if (e.CommandName == "DeleteIntervention")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var grdInterventions = (GridView)ProjectDetail.FindControl("grdInterventions");
                int interventionID = Convert.ToInt32(grdInterventions.DataKeys[index].Value.ToString());

                if (DeleteIntervention(interventionID))
                {
                    grid.PageIndex = 0;
                    grid.DataBind();
                }
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

                if (anIntervention.RelatedProject != null)
                {
                    anIntervention.RelatedProject.LastModified = DateTime.Now;
                    var actionsProject = new ProjectActions();
                    var listHierarchyUp = actionsProject.getHierarchyUp(anIntervention.RelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }

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
                currentProject.LastModified = DateTime.Now;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(currentProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
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
            txtBudget.Text = project.Budget.ToString();
            ddlSelectType.SelectedValue = project.Type;
            txtStartDate.Text = project.CreationDate.ToShortDateString();
            chkPublic.Checked = project.Public;
            ModalPopupProject.Show();
        }

        protected void btnConfirmModify_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            int budget = 0;
            int.TryParse(txtBudget.Text, out budget);
            var project = db.Projects.Where(o => o.ProjectId == _currentProjectId).FirstOrDefault();
            project.ProjectName = txtName.Text;
            project.Description = txtDescription.Text;
            project.CreationDate = Convert.ToDateTime(txtStartDate.Text);
            project.LastModified = DateTime.Now;
            project.Budget = budget;
            project.Public = chkPublic.Checked;
            project.Type = ddlSelectType.SelectedValue;

            var actions = new ProjectActions();
            var listHierarchyUp = actions.getHierarchyUp(project.ProjectId);
            if (listHierarchyUp.Count != 0)
                listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);

            db.SaveChanges();
            Response.Redirect("~/MyVale/ProjectDetails.aspx?projectId=" + _currentProjectId);
        }

        
       

        public IQueryable<Project> GetProjects()
        {
            var _db = new UserOperationsContext();

            var currentUser = _db.UserDatas.FirstOrDefault(u => u.UserName == HttpContext.Current.User.Identity.Name);
            List<Project> projects = _db.Projects.Where(pr => pr.Status != "Chiuso" && pr.ProjectId == _currentProjectId).OrderBy(p => p.ProjectName).ToList();
            List<Project> projectsToShow = new List<Project>();
            foreach (var project in projects)
            {
                if (project.InvolvedUsers.Contains(currentUser))
                    projectsToShow.Add(project);
            }
            return projectsToShow.AsQueryable();
        }

        //++++++++++++++++++++++++++RelatedProject+++++++++++++++++++++++++++++++++

        protected void btnAddRelatedProject_Click(object sender, EventArgs e)
        {
            OpenedProjectList.DataBind();
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
                currentProject.RelatedProjects.Add(project);
                currentProject.LastModified = DateTime.Now;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(currentProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);

                _db.SaveChanges();
                UpdateRelatedProjectView();
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
                return currentProject.RelatedProjects.AsQueryable();
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

       

        private void UpdateRelatedProjectView()
        {
            GridView grdRelatedProject = (GridView)ProjectDetail.FindControl("grdRelatedProject");
            grdRelatedProject.DataBind();
            Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
        }

        public string GetHoursWorked()
        {
            return GetHoursWorkedForProject(_currentProjectId);
        }

        public string GetHoursWorkedForProject(int projectId)
        {
            var project = _db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            int hours;
            var projectActions = new ProjectActions();
            hours = projectActions.GetAllProjectHierarchyHoursWorked(_currentProjectId);
            if (project != null)
            {
                int budget = projectActions.GetProjectHierarchyBudget(_currentProjectId);
                if (budget > 0)
                    return String.Format("Budget Totale: {0} Erogato {1}", budget, hours);
            }
            return String.Format(" {0} Ore di lavoro", hours);
        }

        protected void btnBack_ServerClick(object sender, EventArgs e)
        {
            string returnUrl = "";
            if (Session["ProjectDetailsRequestFrom"] != null)
                returnUrl = Session["ProjectDetailsRequestFrom"].ToString();
            else
                returnUrl = "/MyVale/Projects";
            Session["ProjectDetailsRequestFrom"] = null;
            Response.Redirect(returnUrl);
        }

       

        private void PopulateProjectTreeView()
        {
            TreeView ProjectTreeView = (TreeView)ProjectDetail.FindControl("ProjectTreeView");
            var project = _db.Projects.FirstOrDefault(p => p.ProjectId == _currentProjectId);
            if (project != null)
            {
                ProjectTreeView.Nodes.Clear();
                ProjectTreeView.Nodes.Add(PopulateProjectNode(project));
            }
        }

        private TreeNode PopulateActivityNode(Activity activity)
        {
            var activityNode = new TreeNode { Text = activity.ActivityName };
            activityNode.ChildNodes.Add(new TreeNode { Text = "Creatore: " + activity.Creator.FullName });
            activityNode.ChildNodes.Add(new TreeNode { Text = "Data creazione: " + activity.CreationDate.ToShortDateString() });
            activityNode.ChildNodes.Add(new TreeNode { Text = "Data Inizio: " + (activity.StartDate.HasValue ? activity.StartDate.Value.ToShortDateString() : "Non definita") });
            activityNode.ChildNodes.Add(new TreeNode { Text = "Data Fine: " + (activity.ExpireDate.HasValue ? activity.ExpireDate.Value.ToShortDateString() : "Non definita") });
            activityNode.ChildNodes.Add(new TreeNode { Text = "Tipo: " + activity.Type });
            activityNode.ChildNodes.Add(new TreeNode { Text = "Stato: " + GetActivityStatus(activity) });
            activityNode.ChildNodes.Add(new TreeNode { Text = "Budget: " + activity.Budget });
            return activityNode;
        }

        public string GetActivityStatus(Activity anActivity)
        {
            var activityActions = new ActivityActions();
            return activityActions.GetStatus(anActivity);
        }

        private TreeNode PopulateEventNode(Event Event)
        {
            var eventNode = new TreeNode { Text = Event.Name };
            eventNode.ChildNodes.Add(new TreeNode { Text = "Organizzatore: " + Event.Organizer.FullName });
            eventNode.ChildNodes.Add(new TreeNode { Text = "Data: " + Event.EventDate.ToString() });
            eventNode.ChildNodes.Add(new TreeNode { Text = "Durata(ore): " + Event.Durata });
            eventNode.ChildNodes.Add(new TreeNode { Text = "Visibilità: " + (Event.Public ? "Pubblica" : "Privata") });
            eventNode.ChildNodes.Add(new TreeNode { Text = "Luogo: " + Event.Site });
            return eventNode;
        }

        private TreeNode PopulateProjectInfoNodeNode(Project project)
        {
            var projectInfoNode = new TreeNode { Text = "Informazioni" };
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Creatore: " + project.OrganizerUserName });
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Data: " + project.CreationDate.ToShortDateString() });
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Ultima modifica: " + project.LastModified.ToShortDateString() });
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Tipo: " + project.Type });
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Visibilita: " + (project.Public ? "Pubblica" : "Privata")});
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Stato: " + project.Status });
            projectInfoNode.ChildNodes.Add(new TreeNode { Text = "Budget: " + project.Budget });
            return projectInfoNode;
        }

        private TreeNode PopulateProjectNode(Project project)
        {
            var projectNode = new TreeNode();
            if (IsVisibleProject(project))
            {
                projectNode.Text = project.ProjectName + " (" + GetHoursWorkedForProject(project.ProjectId) + " )";
                var activitiesNode = new TreeNode { Text = "Attività" };
                project.Activities.ForEach(a => activitiesNode.ChildNodes.Add(PopulateActivityNode(a)));
                var eventsNode = new TreeNode { Text = "Eventi" };
                project.Events.ForEach(ev => eventsNode.ChildNodes.Add(PopulateEventNode(ev)));
                var projectInfoNode = PopulateProjectInfoNodeNode(project);
                projectNode.ChildNodes.Add(projectInfoNode);
                projectNode.ChildNodes.Add(activitiesNode);
                projectNode.ChildNodes.Add(eventsNode);
            }
            else 
            {
                projectNode.Text = "Progetto Privato a cui non partecipi (" + GetHoursWorkedForProject(project.ProjectId) + " )";
            }
            var relatedProjectNode = new TreeNode { Text = "Progetti Correlati" };
            project.RelatedProjects.ForEach(p => relatedProjectNode.ChildNodes.Add(PopulateProjectNode(p)));
            projectNode.ChildNodes.Add(relatedProjectNode);
            return projectNode;
        }

        public bool IsVisibleProject(int projectId)
        {
            return IsVisibleProject(_db.Projects.First(p => p.ProjectId == projectId));
        }
        private bool IsVisibleProject(Project project)
        {

            if (HttpContext.Current.User.IsInRole("Amministratore") || project.Organizer.UserName == _currentUserName || project.InvolvedUsers.Select(u => u.UserName).Contains(_currentUserName))
                return true;
            return false;
        }

        protected void grdRelatedProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int relatedProjectId = Convert.ToInt32(e.CommandArgument);
            ProjectActions projectActions = new ProjectActions();
            projectActions.DeletRelatedProject(_currentProjectId, relatedProjectId);
            UpdateRelatedProjectView();
        }


    }
}