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

namespace VALE.MyVale
{
    public partial class ProjectDetails : System.Web.UI.Page
    {
        private int _currentProjectId;
        private string _currentUser;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
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

        public List<string> GetRelatedDocuments([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
            {
                var project = _db.Projects.First(p => p.ProjectId == projectId);
                if (!String.IsNullOrEmpty(project.DocumentsPath))
                {
                    var dir = new DirectoryInfo(Server.MapPath(project.DocumentsPath));
                    var files = dir.GetFiles().Select(f => f.Name).ToList();
                    if (files.Count == 0)
                    {
                        HideControl("lstDocuments");
                        HideControl("btnViewDocument");
                    }
                    return files;
                }
                else
                {
                    HideControl("lstDocuments");
                    HideControl("btnViewDocument");
                    return null;
                }
            }
            else
            {
                HideControl("lstDocuments");
                HideControl("btnViewDocument");
                return null;
            }
        }

        public IQueryable<Intervention> GetInterventions([QueryString("projectId")] int? projectId)
        {

            if (projectId.HasValue)
                return _db.Interventions.Where(i => i.ProjectId == projectId);
            else
                return null;
        }


        private void HideControl(string name)
        {
            Control control = ProjectDetail.FindControl(name);
            control.Visible = false;
        }

        protected void btnSuspendProject_Click(object sender, EventArgs e)
        {
            var project = _db.Projects.First(p => p.ProjectId == _currentProjectId);
            Panel panel = (Panel)ProjectDetail.FindControl("manageProjectPanel");
            Label label = (Label)panel.FindControl("lblInfoOperation");
            panel.Visible = true;
            if (project.Status == "Sospeso")
                label.Text = "RIPRENDI";
            else
                label.Text = "SOSPENDI";
        }

        protected void btnCloseProject_Click(object sender, EventArgs e)
        {
            Panel panel = (Panel)ProjectDetail.FindControl("manageProjectPanel");
            Label label = (Label)panel.FindControl("lblInfoOperation");
            panel.Visible = true;
            label.Text = "CHIUDI";
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
                if (project.InvolvedUsers.Select(u => u.UserName).Contains(_currentUser))
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
            }
        }

        private void SetManageProjectSection(Project project)
        {
            Button btnSuspend = (Button)ProjectDetail.FindControl("btnSuspendProject");
            Button btnClose = (Button)ProjectDetail.FindControl("btnCloseProject");
            Label lblInfo = (Label)ProjectDetail.FindControl("lblInfoManage");
            if (project.OrganizerUserName == _currentUser || User.IsInRole("Amministratore"))
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

        protected void btnModifyProject_Click(object sender, EventArgs e)
        {
            Panel panel = (Panel)ProjectDetail.FindControl("manageProjectPanel");
            Label label = (Label)panel.FindControl("lblInfoOperation");
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser userData = manager.FindById(_currentUser);
            ApplicationUser user = manager.Find(userData.UserName, (panel.FindControl("txtPassword") as TextBox).Text);
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
            else
            {

            }
        }

        protected void btnWorkOnThis_Click(object sender, EventArgs e)
        {
            GridView grdUsers = (GridView)ProjectDetail.FindControl("lstUsers");
            Button btnWork = (Button)sender;
            var db = new UserOperationsContext();
            var project = db.Projects.First(p => p.ProjectId == _currentProjectId);
            var user = db.UsersData.First(u => u.UserName == _currentUser);
            if (project.InvolvedUsers.Contains(user))
            {
                project.InvolvedUsers.Remove(user);
                user.AttendingProjects.Remove(project);
            }
            else
            {
                project.InvolvedUsers.Add(user);
                user.AttendingProjects.Add(project);
            }
            db.SaveChanges();
            grdUsers.DataBind();
            SetWorkOnProjectSection(project);
        }

        protected void btnAddIntervention_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/CreateIntervention?projectId=" + _currentProjectId);
        }

        protected void grdInterventions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            int index = Convert.ToInt32(e.CommandArgument);
            int interventionID = Convert.ToInt32(grid.Rows[index].Cells[0].Text);
            Response.Redirect("/MyVale/InterventionDetails?interventionId=" + interventionID);
        }

        protected void btnViewDocument_Click(object sender, EventArgs e)
        {
            var project = _db.Projects.First(p => p.ProjectId == _currentProjectId);
            var lstDocument = (ListBox)ProjectDetail.FindControl("lstDocuments");
            if(lstDocument.SelectedIndex > -1)
            {
                var file = project.DocumentsPath + lstDocument.SelectedValue;
                Response.Redirect("/DownloadFile.ashx?filePath=" + file + "&fileName=" + lstDocument.SelectedValue);
            }
        }

        public string GetUserName(string userName)
        {
            return _db.UsersData.First(u => u.UserName == userName).FullName;
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
        
    }
}