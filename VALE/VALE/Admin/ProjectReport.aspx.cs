using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Admin
{
    public class InterventionReports
    {
        public string UserFullName { get; set; }
        public int InterventionsCount { get; set; }
    }


    public partial class ProjectReport : System.Web.UI.Page
    {
        private int _currentProjectId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
        }

        protected void grid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            int index = Convert.ToInt32(e.CommandArgument);
            if(e.CommandName == "ViewUserInterventions")
            {
                string userEmail = grid.Rows[index].Cells[2].Text;
                Response.Redirect("/Admin/UserInterventions?projectId=" + _currentProjectId + "&userId=" + userEmail);
            }
            else if(e.CommandName == "ViewActivityReport")
            {
                DropDownList ddlActivitySelect = (DropDownList)frmProjectReport.FindControl("ddlSelectActivity");
                var activityId = Convert.ToInt32(ddlActivitySelect.SelectedValue);
                string userEmail = grid.Rows[index].Cells[2].Text;
                Response.Redirect("/Admin/UserActivities?activityId=" + activityId + "&userId=" + userEmail);
            }
            else
            {

            }
            

        }

        protected void frmProjectReport_DataBound(object sender, EventArgs e)
        {
            if (_currentProjectId != 0)
            {
                GetInterventions();
            }
        }

        public List<InterventionReports> GetInterventions()
        {
            var result = new List<InterventionReports>();
            var dbData = new UserOperationsContext();
            //var userIds = dbData.Projects.First(p => p.ProjectId == _currentProjectId).InvolvedUsers.Select(u => u.UserDataId);
            var list = dbData.Interventions.GroupBy(i => i.Creator).Select(o => new { User = o.Key.FullName, Email = o.Key.Email, Interventions = o.Count() }).ToList();
            GetGridView("grdUsersInterventions").DataSource = list;
            GetGridView("grdUsersInterventions").DataBind();
            return result;
        }

        public Project GetProject([QueryString("projectId")] int? projectId)
        {
            if (projectId.HasValue)
            {
                var db = new UserOperationsContext();
                var project = db.Projects.Where(a => a.ProjectId == projectId).First();
                return project;
            }
            else
                return null;
        }

        private GridView GetGridView(string name)
        {
            return (GridView)frmProjectReport.FindControl(name);
        }

        public List<Activity> GetActivities()
        {
            var db = new UserOperationsContext();
            var activities = db.Projects.First(p => p.ProjectId == _currentProjectId).Activities;

            var fakeActivity = new Activity() { ActivityId = 0, ActivityName = "Seleziona" };
            activities.Insert(0, fakeActivity);

            var emptyLabel = (Label)frmProjectReport.FindControl("emptyAtcivitiesLabel");
            var dropdownlistActivities = (DropDownList)frmProjectReport.FindControl("ddlSelectActivity");
            var reportBtn = (Button)frmProjectReport.FindControl("btnShowActivityReport");
            var gridViewReport = (GridView)frmProjectReport.FindControl("grdActivitiesReport");
            if (activities.Count == 1)
            {
                dropdownlistActivities.Visible = false;
                emptyLabel.Visible = true;
                emptyLabel.Text = "Non ci sono attività correlate.";
                
                reportBtn.Visible = false;
                gridViewReport.Visible = false;
            }
            else
            {
                dropdownlistActivities.Visible = true;
                emptyLabel.Visible = false;
                emptyLabel.Text = "";
                reportBtn.Visible = true;
                gridViewReport.Visible = true;
            }
            return activities;
        }

        protected void btnShowActivityReport_Click(object sender, EventArgs e)
        {
            DropDownList ddlActivitySelect = (DropDownList)frmProjectReport.FindControl("ddlSelectActivity");
            var db = new UserOperationsContext();
            if (!String.IsNullOrEmpty(ddlActivitySelect.SelectedValue))
            {
                var activityId = Convert.ToInt32(ddlActivitySelect.SelectedValue);
                var reports = db.Reports.Where(r => r.ActivityId == activityId)
                    .GroupBy(r => r.Worker).Select(gr => new { User = gr.Key.FullName, Email = gr.Key.Email, Hours = gr.Sum(r => r.HoursWorked) });
                GetGridView("grdActivitiesReport").DataSource = reports.ToList();
                GetGridView("grdActivitiesReport").DataBind();
            }
        }
    }
}