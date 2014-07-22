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

namespace VALE.MyVale
{
    public partial class PersonalActivities : System.Web.UI.Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();

        }

        protected void ddlSelectProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            List<Activity> activities = new List<Activity>();
            var projectId = Convert.ToInt32(ddlSelectProject.SelectedValue);
            var project = db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            if (project != null)
                activities = project.Activities.ToList();
            activities.Insert(0, new Activity { ActivityName = "Tutte", ActivityId = 0 });
            ddlSelectActivity.DataSource = activities;
            ddlSelectActivity.DataBind();
        }

        public List<Project> GetProjects()
        {
            var db = new UserOperationsContext();
            var projects = db.UserDatas.First(u => u.UserName == _currentUser).AttendingProjects.Where(p=>p.Activities.Count > 0).ToList();
            projects.Insert(0, new Project { ProjectName = "-- Seleziona progetto --", ProjectId = 0 });
            return projects;
        }

        protected void bnViewReports_Click(object sender, EventArgs e)
        {
            grdActivityReport.DataBind();
        }


        public IQueryable<VALE.Models.ActivityReport> grdActivityReport_GetData()
        {
            var db = new UserOperationsContext();
            if (ddlSelectProject.SelectedIndex == 0)
            {
                return db.Reports.Where(r => r.WorkerUserName == _currentUser && r.WorkedActivity.RelatedProject == null).OrderByDescending(r => r.ActivityReportId).AsQueryable();
            }
            else 
            {
                var activityId = Convert.ToInt32(ddlSelectActivity.SelectedValue);
                return db.Reports.Where(r => r.WorkerUserName == _currentUser && r.ActivityId == activityId).OrderByDescending(r => r.ActivityReportId).AsQueryable();
            }
        }
    }
}