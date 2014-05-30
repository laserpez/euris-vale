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
        private string _currentUserId;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUserId = User.Identity.GetUserId();
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
            if (project.Status == "suspended")
                label.Text = "RESUME";
            else
                label.Text = "SUSPEND";
        }

        protected void btnCloseProject_Click(object sender, EventArgs e)
        {
            Panel panel = (Panel)ProjectDetail.FindControl("manageProjectPanel");
            Label label = (Label)panel.FindControl("lblInfoOperation");
            panel.Visible = true;
            label.Text = "CLOSE";
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
            
            if (project.Status == "open")
            {
                if (project.InvolvedUsers.Select(u => u.UserDataId).Contains(_currentUserId))
                {
                    btnWork.Enabled = true;
                    btnWork.CssClass = "btn btn-success";
                    btnWork.Text = "You are working on this project";
                    btnAddIntervention.Enabled = true;
                    btnAddIntervention.CssClass = "btn btn-info";
                    btnAddIntervention.Text = "Add intervention";
                }
                else
                {
                    btnWork.Enabled = true;
                    btnWork.CssClass = "btn btn-info";
                    btnWork.Text = "Work on this project";
                    btnAddIntervention.Enabled = false;
                    btnAddIntervention.CssClass = "btn btn-info disable";
                    btnAddIntervention.Text = "Cannot add intervention";
                }
            }
            else
            {
                btnWork.Enabled = false;
                btnWork.CssClass = "btn btn-info disable";
                btnWork.Text = "Cannot work on this project";
            }
        }

        private void SetManageProjectSection(Project project)
        {
            Button btnSuspend = (Button)ProjectDetail.FindControl("btnSuspendProject");
            Button btnClose = (Button)ProjectDetail.FindControl("btnCloseProject");
            Label lblInfo = (Label)ProjectDetail.FindControl("lblInfoManage");
            if (project.OrganizerId == _currentUserId || User.IsInRole("Administration"))
            {
                if (project.Status == "open")
                {
                    btnSuspend.Text = "Suspend project";
                    btnSuspend.Enabled = true;
                    btnSuspend.CssClass = "btn btn-warning";
                    btnClose.Text = "Close project";
                    btnClose.Enabled = true;
                    btnClose.CssClass = "btn btn-danger";
                }
                else if (project.Status == "suspended")
                {
                    btnSuspend.Text = "Resume project";
                    btnSuspend.Enabled = true;
                    btnSuspend.CssClass = "btn btn-warning";
                    btnClose.Text = "Close project";
                    btnClose.Enabled = true;
                    btnClose.CssClass = "btn btn-danger";
                }
                else
                {
                    btnSuspend.Text = "This project is closed";
                    btnSuspend.Enabled = false;
                    btnSuspend.CssClass = "btn btn-warning disabled";
                    btnClose.Text = "This project is closed";
                    btnClose.Enabled = false;
                    btnClose.CssClass = "btn btn-danger disabled";
                }
            }
            else
            {
                btnSuspend.Visible = false;
                btnClose.Visible = false;
                lblInfo.Text = "Only organizator can manage this project";
            }
        }

        protected void btnModifyProject_Click(object sender, EventArgs e)
        {
            Panel panel = (Panel)ProjectDetail.FindControl("manageProjectPanel");
            Label label = (Label)panel.FindControl("lblInfoOperation");
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser userData = manager.FindById(_currentUserId);
            ApplicationUser user = manager.Find(userData.UserName, (panel.FindControl("txtPassword") as TextBox).Text);
            if (user != null)
            {
                var db = new UserOperationsContext();
                var project = db.Projects.First(p => p.ProjectId == _currentProjectId);

                switch (label.Text)
                {
                    case "SUSPEND":
                        project.Status = "suspended";
                        break;
                    case "CLOSE":
                        project.Status = "closed";
                        break;
                    case "RESUME":
                        project.Status = "open";
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
            var user = db.UsersData.First(u => u.UserDataId == _currentUserId);
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

        public string GetUserName(string userId)
        {
            return _db.UsersData.First(u => u.UserDataId == userId).FullName;
        }

        public bool ContainsDocuments(string path)
        {
            DirectoryInfo dir = new DirectoryInfo(Server.MapPath(path));
            return dir.GetFiles().Count() > 0;
        }
        
    }
}