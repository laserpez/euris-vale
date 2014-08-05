using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using CsvHelper;
using System.IO;
using System.Text;
using VALE.Logic;
using System.Web.ModelBinding ;

namespace VALE.MyVale
{
    public partial class Activities : Page
    {
        private string _currentUserName;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUserName = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                ActivitiesMode();
                hideFilters();
                btnClearFilters_Click(null, null);
                if (GetPendingActivities().Count() > 0) 
                {
                    ActivityListType.Text = "RequestActivities";
                    RequestsMode();
                }
                ShowAdminButton();
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Attivita"))
            {
                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina Activities.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
            
        }

        public string GetStatus(Activity anActivity)
        {
            string status;
            var activityActions = new ActivityActions();
                status = activityActions.GetStatus(anActivity);
            return status;
        }

        public IQueryable<Activity> GetPendingActivities()
        {
            IQueryable<Activity> activities;
            var activityActions = new ActivityActions();
                activities = activityActions.GetPendingActivities(_currentUserName);
            return activities;
 
        }

        protected void btnCreateActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/Create/ActivityCreate?From=/MyVale/Activities");
        }

        protected void grdCurrentActivities_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int activityId = (int)grdCurrentActivities.DataKeys[index].Value;
                Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
            }
        }

        public List<ActivityType> GetTypes()
        {
            var db = new UserOperationsContext();
            var list = db.ActivityTypes.ToList();
            list.Insert(0, new ActivityType {ActivityTypeName="Tutti"});
            return list;
        }

        protected void grdPendingActivities_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int activityId = Convert.ToInt32(grdPendingActivities.DataKeys[index].Value);
            var activityActions = new ActivityActions();
            var accept = false;
            if (e.CommandName == "AcceptActivity")
                accept = true;
            activityActions.AddOrRefusePendingActivity(activityId, accept);
            string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
            Response.Redirect(pageUrl);
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            ExportToCSV(_currentUserName);
        }

        protected void btnAddActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ActivityCreate?From=~/MyVale/Activities");
        }

        public void ExportToCSV(string userName)
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerUserName == userName).Select(r => r.ActivityId);
            var activities = db.Activities.Where(a => activitiesId.Contains(a.ActivityId));
            var activitiesToExport = ApplyFilters(activities).ToList();
            using (var exportToCSV = new ExportToCSV())
            {

                Response.AddHeader("content-disposition", string.Format("attachment; filename=ListActivities({0}).csv", userName));
                Response.ContentType = "application/text";
                StringBuilder strbldr = exportToCSV.ExportActivities(activitiesToExport, userName);
                Response.Write(strbldr.ToString());
                Response.End();
            }
        }

        public string GetType(string typeId) 
        {
            var Id = Convert.ToInt32(typeId);
            var db = new UserOperationsContext();
            var type = db.ActivityTypes.FirstOrDefault(t => t.ActivityTypeId == Id);
            if (type != null)
                return type.ActivityTypeName;
            return "Generico";
        }

        public List<string> PopulateDropDown()
        {
            return new List<string>() { "Tutti", "Da pianificare", "In corso", "Sospese", "Terminate" };
        }

        protected void ChangeSelectedActivities_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            btnClearFilters_Click(null, null);
            hideFilters();
            btnList.InnerHtml = GetButtonName(button.Text) + " <span class=\"caret\">";
            HeaderName.Text = GetButtonName(button.Text);
            switch (button.CommandArgument)
            {
                case "AllActivities":
                    ActivityListType.Text = "AllActivities";
                    ActivitiesMode();
                    break;
                case "RequestActivities":
                    ActivityListType.Text = "RequestActivities";
                    RequestsMode();
                    break;
                case "ProjectActivities":
                    ActivityListType.Text = "ProjectActivities";
                    showFilters();
                    ActivitiesMode();
                    break;
                case "NotRelatedActivities":
                    ActivityListType.Text = "NotRelatedActivities";
                    ActivitiesMode();
                    break;
            }
            
        }
        private string GetButtonName(string html)
        {
            string[] lineTokens = html.Split('>');
            return lineTokens[2].Trim();
        }

        private void ActivitiesMode() 
        {
            grdCurrentActivities.Visible = true;
            grdPendingActivities.Visible = false;
            grdCurrentActivities.DataBind();
            filters.Visible = true;
            btnExportCSV.Visible = true;
            ShowAdminButton();
        }
        private void RequestsMode()
        {
            btnList.InnerHtml = "Richieste <span class=\"caret\">";
            HeaderName.Text = "Richieste";
            filters.Visible = false;
            btnAddActivity.Visible = false;
            btnExportCSV.Visible = false;
            grdPendingActivities.Visible = true;
            grdCurrentActivities.Visible = false;
            grdPendingActivities.DataBind();
            divAllOrPersonal.Visible = false;
        }



        private IQueryable<Activity> ApplyFilters(IQueryable<Activity> activities)
        {
            switch (ActivityListType.Text)
            {
                case "AllActivities":
                default:
                    break;
                case "ProjectActivities":
                    var projectId = 0;
                    int.TryParse(ddlSelectProject.SelectedValue, out projectId);
                    activities = activities.Where(a => a.RelatedProject != null && a.RelatedProject.ProjectId == projectId);
                    
                    break;
                case "NotRelatedActivities":
                    activities = activities.Where(a => a.RelatedProject == null);
                    break;
            }
            var status = ddlStatus.SelectedValue;
            if (ddlStatus.SelectedIndex > 0)
            {
                ActivityStatus statusFilter = ActivityStatus.Deleted;
                switch (status)
                {
                    case "Da pianificare":
                        statusFilter = ActivityStatus.ToBePlanned;
                        break;
                    case "In corso":
                        statusFilter = ActivityStatus.Ongoing;
                        break;
                    case "Sospese":
                        statusFilter = ActivityStatus.Suspended;
                        break;
                    case "Terminata":
                        statusFilter = ActivityStatus.Done;
                        break;
                }
                activities = activities.Where(a => a.Status == statusFilter);
            }
            var type = ddlSelectType.SelectedValue;
            if (ddlSelectType.SelectedIndex > 0)
            {
                activities = activities.Where(a => a.Type == type);
            }

            if (txtDescription.Text != "")
                activities = activities.Where(a => a.Description.ToUpper().Contains(txtDescription.Text.ToUpper()));
            if (txtName.Text != "")
                activities = activities.Where(a => a.ActivityName.ToUpper().Contains(txtName.Text.ToUpper()));
            if (txtFromDate.Text != "")
            {
                var dateFrom = Convert.ToDateTime(txtFromDate.Text);
                activities = activities.Where(a => a.CreationDate >= dateFrom);
            }
            if (txtToDate.Text != "")
            {
                var dateTo = Convert.ToDateTime(txtToDate.Text);
                activities = activities.Where(a => a.CreationDate <= dateTo);
            }
            return activities;

        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            if (filterPanel.Visible)
                hideFilters();
            else
                showFilters();
        }

        private void showFilters()
        {
            if (ActivityListType.Text == "ProjectActivities")
                projectPanel.Visible = true;
            else
                projectPanel.Visible = false;
            btnFilterProjects.Visible = true;
            btnClearFilters.Visible = true;
            filterPanel.Visible = true;
            btnShowFilters.Text = "Nascondi filtri";
        }

        private void hideFilters()
        {
            btnFilterProjects.Visible = false;
            btnClearFilters.Visible = false;
            filterPanel.Visible = false;
            btnShowFilters.Text = "Visualizza filtri";
        }

        public List<Project> GetProjects()
        {
            var db = new UserOperationsContext();
            var userName = User.Identity.Name;
            List<Project> projects = new List<Project>();
            if (lblAllOrPersonal.Text == "Personal")
            {
                projects = db.UserDatas.First(u => u.UserName == userName).AttendingProjects;
            }
            else 
            {
                projects = db.Projects.Where(p => p.Activities.Count > 0).ToList();
            }
            projects.Insert(0, new Project { ProjectName = "-- Seleziona progetto --", ProjectId = 0 });
            return projects;
        }

        protected void ddlSelectProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            grdCurrentActivities.DataBind();
        }

        public IQueryable<Activity> GetActivities()
        {
            var db = new UserOperationsContext();
            if (lblAllOrPersonal.Text == "Personal")
            {
                var activitiesId = db.Reports.Where(r => r.WorkerUserName == _currentUserName).Select(r => r.ActivityId);
                var activities = db.Activities.Where(a => activitiesId.Contains(a.ActivityId)).OrderByDescending(a => a.CreationDate);
                return ApplyFilters(activities);
            }
            else
            {
                var activities = db.Activities;
                return ApplyFilters(activities);
            }
            
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            grdCurrentActivities.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtDescription.Text = null;
            txtFromDate.Text = null;
            txtName.Text = null;
            txtToDate.Text = null;
            ddlSelectType.DataBind();
            ddlSelectType.SelectedIndex = 0;
            ddlStatus.DataBind();
            ddlStatus.SelectedIndex = 0;
            grdCurrentActivities.DataBind();
        }

        protected void txtFromDate_TextChanged(object sender, EventArgs e)
        {
            ChangeCalendars();
        }

        private void ChangeCalendars()
        {
            if (txtFromDate.Text != "" && CheckDate())
            {
                txtToDate.Enabled = true;
                calendarModifiedDate.StartDate = Convert.ToDateTime(txtFromDate.Text).AddDays(1);
            }

        }

        private bool CheckDate()
        {
            if (!String.IsNullOrEmpty(txtToDate.Text))
            {
                var startDate = Convert.ToDateTime(txtFromDate.Text);
                var endDate = Convert.ToDateTime(txtToDate.Text);
                if (startDate > endDate)
                {
                    txtToDate.Text = "";
                    calendarModifiedDate.StartDate = Convert.ToDateTime(txtFromDate.Text);
                    return false;
                }
            }
            return true;
        }

        public string GetDescription(string description)
        {
            if (!String.IsNullOrEmpty(description))
            {
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(description);
                description = doc.DocumentNode.InnerText;
                return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
            }
            else
            {
                return "Nessuna descrizione presente";
            }
        }

        protected void btnPersonalLinkButton_Click(object sender, EventArgs e)
        {
            lblAllOrPersonal.Text = "Personal";
            btnPersonal.Visible = true;
            btnAllUsers.Visible = false;
            grdCurrentActivities.DataBind();
        }

        protected void btnAllUsersLinkButton_Click(object sender, EventArgs e)
        {
            lblAllOrPersonal.Text = "All";
            btnPersonal.Visible = false;
            btnAllUsers.Visible = true;
            grdCurrentActivities.DataBind();
        }

        private void ShowAdminButton() 
        {
            if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
                divAllOrPersonal.Visible = true;
        }

       


    }
}
