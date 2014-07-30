using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.Admin
{
    public class InterventionReports
    {
        public string Username { get; set; }
        public string Email { get; set; }
        public int InterventionsCount { get; set; }
    }

    public class UserActivityReport
    {
        public string Username { get; set; }
        public string Email { get; set; }
        public int HoursWorked { get; set; }
    }

    public partial class ProjectReport : Page
    {
        private int _currentProjectId;

        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "Amministrazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ProjectReport.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        protected void grid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            if(e.CommandName == "ViewUserInterventions")
            {
                var userEmail = e.CommandArgument.ToString();
                Response.Redirect("/Admin/UserInterventions?projectId=" + _currentProjectId + "&userId=" + userEmail);
            }
            else if(e.CommandName == "ViewActivityReport")
            {
                var userEmail = e.CommandArgument.ToString();
                DropDownList ddlActivitySelect = (DropDownList)frmProjectReport.FindControl("ddlSelectActivity");
                var activityId = Convert.ToInt32(ddlActivitySelect.SelectedValue);
                
                Response.Redirect("/Admin/UserActivities?activityId=" + activityId + "&userId=" + userEmail);
            }
        }
        protected void frmProjectReport_DataBound(object sender, EventArgs e)
        {
            if (_currentProjectId != 0)
            {
                GetInterventions();
            }

            var db = new UserOperationsContext();
            string result = db.Projects.First(p => p.ProjectId == _currentProjectId).Description;
            Label lblContent = (Label)frmProjectReport.FindControl("lblContent");
            lblContent.Text = result;
        }

        public void GetInterventions()
        {
            var dbData = new UserOperationsContext();
            //var userIds = dbData.Projects.First(p => p.ProjectId == _currentProjectId).InvolvedUsers.Select(u => u.UserDataId);
            var list = dbData.Interventions.Where(i => i.ProjectId == _currentProjectId).GroupBy(i => i.Creator).Select(gr => new InterventionReports { Username = gr.Key.FullName, Email = gr.Key.Email, InterventionsCount = gr.Count() }).ToList();

            GetGridView("grdUsersInterventions").DataSource = list.ToList();
            GetGridView("grdUsersInterventions").DataBind();
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
                var reports = db.Reports.Where(r => r.ActivityId == activityId).GroupBy(r => r.Worker).Select(gr => new UserActivityReport() { Username = gr.Key.FullName, Email = gr.Key.Email, HoursWorked = gr.Sum(r => r.HoursWorked) });
                
                GetGridView("grdActivitiesReport").DataSource = reports.ToList();
                GetGridView("grdActivitiesReport").DataBind();
            }
        }

        protected void grd_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            var grdView = (GridView)sender;
            grdView.PageIndex = e.NewPageIndex;
            grdView.DataBind();
        }
    }
}