using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using System.Web.UI.WebControls;
using VALE.Models;
using System.Linq.Expressions;
using VALE.Logic;
using System.Text;

namespace VALE.MyVale
{
    public partial class SummaryInterventions : Page
    {
        private string _currentUser;
        private UserOperationsContext _db = new UserOperationsContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                UpdateGraphic();
            }
        }

        public IQueryable<SummaryIntervention> grdActivityReport_GetData()
        {
            return ApplyFilters(GetSummaryInterventions()).AsQueryable();
        }

        private List<SummaryIntervention> GetSummaryInterventions()
        {
            List<ActivityReport> reports = new List<ActivityReport>();
            if (ddlActivity.SelectedIndex == 0)
            {
                var activities = GetActivities();
                foreach (var activity in activities)
                {
                    var reportsRange = _db.Reports.Where(r => r.ActivityId == activity.ActivityId).OrderByDescending(r => r.ActivityReportId).ToList();
                    reports.AddRange(reportsRange);
                }
                return CreateSummaryInterventionsList(reports);
            }
            else
            {
                var activityId = Convert.ToInt32(ddlActivity.SelectedValue);
                reports = _db.Reports.Where(r => r.ActivityId == activityId).OrderByDescending(r => r.ActivityReportId).ToList();
                return CreateSummaryInterventionsList(reports);
            }
        }

        private List<SummaryIntervention> CreateSummaryInterventionsList(List<ActivityReport> activityReport)
        {
            List<SummaryIntervention> summaryInterventions = new List<SummaryIntervention>();
            activityReport.ForEach(a => summaryInterventions.Add(new VALE.Models.SummaryIntervention
            {
                ProjectType = a.WorkedActivity.RelatedProject != null ? a.WorkedActivity.RelatedProject.Type : "",
                ProjectName = a.WorkedActivity.RelatedProject != null ? a.WorkedActivity.RelatedProject.ProjectName : "",
                RelatedProjectName = a.WorkedActivity.RelatedProject.RelatedProject != null ? a.WorkedActivity.RelatedProject.RelatedProject.ProjectName : "",
                ActivityName = a.WorkedActivity.ActivityName,
                ActivityType = a.WorkedActivity.Type,
                ActivityDescription = a.ActivityDescription,
                HoursWorked = a.HoursWorked,
                Date = a.Date,
                WorkerUserName = a.WorkerUserName,
                ProjectPublic = a.WorkedActivity.RelatedProject.Public == true ? "SI" : "NO",
            }));
            return summaryInterventions;
        }

        private List<SummaryIntervention> ApplyFilters(List<SummaryIntervention> summaryInterventions)
        {
            if (!String.IsNullOrEmpty(txtFromDate.Text))
            {
                var dateFrom = Convert.ToDateTime(txtFromDate.Text);
                summaryInterventions = summaryInterventions.Where(s => s.Date >= dateFrom).ToList();
            }
            if (!String.IsNullOrEmpty(txtToDate.Text))
            {
                var dateTo = Convert.ToDateTime(txtToDate.Text);
                summaryInterventions = summaryInterventions.Where(s => s.Date <= dateTo).ToList();
            }
            return summaryInterventions;
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            using (var exportToCSV = new ExportToCSV())
            {
                Response.AddHeader("content-disposition", string.Format("attachment; filename=RiepilogoInterventi({0}).csv", _currentUser));
                Response.ContentType = "application/text";
                StringBuilder strbldr = exportToCSV.ExportSummaryInterventions(ApplyFilters(GetSummaryInterventions()));
                Response.Write(strbldr.ToString());
                Response.End();
            }
        }
        
        private List<UserData> GetUsers() 
        {
            List<UserData> users;
            if (ddlUserGroup.SelectedIndex == 0)
            {
                users = _db.UserDatas.ToList();
            }
            else
            {
                var groupId = Convert.ToInt32(ddlUserGroup.SelectedValue);
                users = _db.UserDatas.Where(u => u.JoinedGroups.FirstOrDefault(g => g.GroupId == groupId) != null).ToList();
            }
            return users;
        }

        protected void ddlUserGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            var users = GetUsers();
            users.Insert(0, new UserData { UserName = "-- Tutti Utenti --" });
            ddlUser.DataSource = users;
            ddlUser.DataBind();
            ddlUser_SelectedIndexChanged(null, null);
        }

        private List<Project> GetProjectsFromUser() 
        {
            List<Project> projects = new List<Project>();
            if (lblAllOrPersonal.Text == "All")
            {
                if (ddlUser.SelectedIndex == 0)
                {
                    List<UserData> users;
                    if (ddlUserGroup.SelectedIndex == 0)
                        users = _db.UserDatas.ToList();
                    else
                    {
                        var groupId = Convert.ToInt32(ddlUserGroup.SelectedValue);
                        var group = _db.Groups.Where(g => g.GroupId == groupId).FirstOrDefault();
                        users = _db.UserDatas.Where(u => u.JoinedGroups.FirstOrDefault(g => g.GroupId == groupId) != null).ToList();
                    }
                    foreach (var user in users)
                    {
                        var projectsRange = _db.UserDatas.First(u => u.UserName == user.UserName).AttendingProjects.Where(p => p.Activities.Count > 0).ToList();
                        projects.AddRange(projectsRange);
                    }
                }
                else
                {
                    var userName = ddlUser.SelectedValue;
                    projects = _db.UserDatas.First(u => u.UserName == userName).AttendingProjects.Where(p => p.Activities.Count > 0).ToList();
                }
            }
            else 
            {
                var projectsRange = _db.UserDatas.First(u => u.UserName == _currentUser).AttendingProjects.Where(p => p.Activities.Count > 0).ToList();
                projects.AddRange(projectsRange);
            }
            return projects; 
        }

        private List<string> GetTypesProject() 
        {
            HashSet<string> setOfTypes = new HashSet<string>();
            var projects = GetProjectsFromUser();
            projects.ForEach(p => setOfTypes.Add(p.Type));
            var types = setOfTypes.ToList();
            return types;
        }
        protected void ddlUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ProjectOrNorRelated.Text == "Project")
            {
                var types = GetTypesProject();
                types.Insert(0, "-- Tutti Tipi di Progetto --");
                ddlProjectType.DataSource = types;
                ddlProjectType.DataBind();
                ddlProjectType_SelectedIndexChanged(null, null);
            }
            else
                ddlProject_SelectedIndexChanged(null, null);
        }

        private List<Project> GetProjectsFromType()
        {
            List<Project> projects = new List<Project>();
            if (ddlProjectType.SelectedIndex == 0)
            {
                projects = GetProjectsFromUser();
            }
            else 
            {
                var typeName = ddlProjectType.SelectedValue;
                projects = GetProjectsFromUser().Where(p => p.Type == typeName).ToList();
            }
            return projects;
        }

        protected void ddlProjectType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var projects = GetProjectsFromType();
            projects.Insert(0, new Project{ ProjectId = 0, ProjectName = "-- Tutti Progetti --"});
            ddlProject.DataSource = projects;
            ddlProject.DataBind();
            ddlProject_SelectedIndexChanged(null, null);
        }



        private List<string> GetTypesActivity()
        {
            HashSet<string> setOfGroups = new HashSet<string>();
            var activities = GetActivitiesFromProject();
            activities.ForEach(a => setOfGroups.Add(a.Type));
            var types = setOfGroups.ToList();
            return types;
        }

        private List<Activity> GetActivitiesFromProject()
        {
            var projectActions = new ProjectActions();
            List<Activity> activities = new List<Activity>();
            if (ProjectOrNorRelated.Text == "Project")
            {
                if (ddlProject.SelectedIndex == 0)
                {
                    var projects = GetProjectsFromType();
                    HashSet<Activity> setOfActivities = new HashSet<Activity>();
                    projects.ForEach(p => p.Activities.ForEach(a => setOfActivities.Add(a)));
                    activities = setOfActivities.ToList();
                }
                else
                {
                    var projectId = Convert.ToInt32(ddlProject.SelectedValue);
                    var project = _db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
                    if (project != null)
                    {
                        activities = project.Activities.ToList();
                        var projects = projectActions.getHierarchyDown(project.ProjectId);
                        projects.ForEach(p => activities.AddRange(p.Activities.ToList()));
                    }
                }
            }
            else 
            {
                if (lblAllOrPersonal.Text == "All")
                {
                    if (ddlUser.SelectedIndex == 0)
                    {
                        List<UserData> users;
                        if (ddlUserGroup.SelectedIndex == 0)
                            users = _db.UserDatas.ToList();
                        else
                        {
                            var groupId = Convert.ToInt32(ddlUserGroup.SelectedValue);
                            var group = _db.Groups.Where(g => g.GroupId == groupId).FirstOrDefault();
                            users = _db.UserDatas.Where(u => u.JoinedGroups.FirstOrDefault(g => g.GroupId == groupId) != null).ToList();
                        }
                        foreach (var user in users)
                        {
                            _db.Reports.Where(r => r.WorkerUserName == user.UserName && r.WorkedActivity.RelatedProject == null).ToList().ForEach(r => activities.Add(r.WorkedActivity));
                        }
                    }
                    else
                    {
                        var userName = ddlUser.SelectedValue;
                        _db.Reports.Where(r => r.WorkerUserName == userName && r.WorkedActivity.RelatedProject == null).ToList().ForEach(r => activities.Add(r.WorkedActivity));
                    }
                }
                else 
                {
                    _db.Reports.Where(r => r.WorkerUserName == _currentUser && r.WorkedActivity.RelatedProject == null).ToList().ForEach(r => activities.Add(r.WorkedActivity));
                }
            }
            
            return activities;
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            var typesActivity = GetTypesActivity();
            typesActivity.Insert(0, "-- Tutti Tipi di Attività --");
            ddlActivityType.DataSource = typesActivity;
            ddlActivityType.DataBind();
            ddlActivityType_SelectedIndexChanged(null, null);
        }

        private List<Activity> GetActivities() 
        {
            List<Activity> activities = new List<Activity>();
            if (ddlActivityType.SelectedIndex == 0)
            {
                activities = GetActivitiesFromProject();
            }
            else 
            {
                var type = ddlActivityType.SelectedValue;
                activities = GetActivitiesFromProject().Where(a => a.Type == type).ToList();
            }
            return activities;
        }
        protected void ddlActivityType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var activities = GetActivities();
            activities.Insert(0, new Activity { ActivityId = 0, ActivityName = "-- Tutte le Attività --" });
            ddlActivity.DataSource = activities;
            ddlActivity.DataBind();
        }

        protected void btnFiltersVisibility_Click(object sender, EventArgs e)
        {
            if (lblFilterVisibility.Text == "False")
                ShowFilters();
            else
                HideFilters();
        }

        private void ShowFilters()
        {
            filterPanel.Visible = true;
            Session["SummaryInterventions_FilterVisibility"] = "True";
            lblFilterVisibility.Text = "True";
        }

        private void HideFilters()
        {
            filterPanel.Visible = false;
            Session["SummaryInterventions_FilterVisibility"] = "False";
            lblFilterVisibility.Text = "False";
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            grdActivityReport.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = "";
            txtToDate.Text = "";
            UpdateGraphic();
        }

        private void UpdateGraphic()
        {
            if (lblAllOrPersonal.Text == "Personal")
            {
                UserPanel.Visible = false;
                btnPersonal.Visible = true;
                btnAllUsers.Visible = false;
            }
            else
            {
                UserPanel.Visible = true;
                btnPersonal.Visible = false;
                btnAllUsers.Visible = true;
               
            }

            if (ProjectOrNorRelated.Text == "Project")
            {

                projectPanel.Visible = true;
                btnProjectActivities.Visible = true;
                btnNotRelatedActivities.Visible = false;
            }
            else
            {
                projectPanel.Visible = false;
                btnProjectActivities.Visible = false;
                btnNotRelatedActivities.Visible = true;
            }

            LoadData();
        }

        private void LoadData()
        {
            if (lblAllOrPersonal.Text == "Personal")
            {
                ddlUser_SelectedIndexChanged(null, null);
            }
            else
            {
                var groups = _db.Groups.ToList();
                groups.Insert(0, new Group { GroupId = 0, GroupName = "-- Tutti --" });
                ddlUserGroup.DataSource = groups;
                ddlUserGroup.DataBind();
                ddlUserGroup_SelectedIndexChanged(null, null);
            }
            grdActivityReport.DataBind();
        }


        protected void btnPersonalLinkButton_Click(object sender, EventArgs e)
        {
            lblAllOrPersonal.Text = "Personal";
            Session["SummaryInterventions_AllOrPersonal"] = "Personal";
            UpdateGraphic();
        }

        protected void btnAllUsersLinkButton_Click(object sender, EventArgs e)
        {
            lblAllOrPersonal.Text = "All";
            Session["SummaryInterventions_AllOrPersonal"] = "All";
            UpdateGraphic();
        }

        protected void btnProjectActivitiesLinkButton_Click(object sender, EventArgs e)
        {
            ProjectOrNorRelated.Text = "Project";
            Session["SummaryInterventions_ProjectOrNorRelated"] = "Project";
            UpdateGraphic();
        }

        protected void btnNotRelatedActivitiesLinkButton_Click(object sender, EventArgs e)
        {
            ProjectOrNorRelated.Text = "NotRelated";
            Session["SummaryInterventions_ProjectOrNorRelated"] = "NotRelated";
            UpdateGraphic();
        }
        
    }
}