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
    public partial class Activities : System.Web.UI.Page
    {
        private string _currentUserName;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserName = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                filterPanel.Visible = false;
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ShowHideControls();
        }

        private void ShowHideControls()
        {
            if (grdCurrentActivities.Rows.Count == 0 && grdPendingActivities.Rows.Count == 0)
            {
                filterPanel.Visible = false;
                btnShowFilters.Visible = false;
                ExternalPanelDefault.Visible = false;
                InternalPanelHeading.Visible = false;
                btnExportCSV.Visible = false;
            }
        }

        public IQueryable<Activity> GetCurrentActivities([Control]string txtName, [Control]string txtDescription, [Control]string ddlStatus)
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerUserName == _currentUserName).Select(r => r.ActivityId);
            var activities = db.Activities.Where(a => activitiesId.Contains(a.ActivityId));
            if (txtName != null)
                activities = activities.Where(a => a.ActivityName.ToUpper().Contains(txtName.ToUpper()));
            if(txtDescription != null)
                activities = activities.Where(a => a.Description.ToUpper().Contains(txtDescription.ToUpper()));
            if(ddlStatus != null && ddlStatus != "Tutte")
            {
                ActivityStatus statusFilter = ActivityStatus.Deleted;
                switch(ddlStatus)
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
            return activities;
        }

        public IQueryable<Activity> GetPendingActivities()
        {
            var db = new UserOperationsContext();
            var activities = db.UsersData.First(u => u.UserName == _currentUserName).PendingActivity.AsQueryable();
            return activities;
        }

        protected void btnCreateActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/ActivityCreate");
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

        protected void grdPendingActivities_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int activityId = Convert.ToInt32(grdPendingActivities.DataKeys[index].Value);
            var db = new UserOperationsContext();
            var activity = db.Activities.First(a => a.ActivityId == activityId);
            var user = db.UsersData.First(u => u.UserName == _currentUserName);
            if (e.CommandName == "AcceptActivity")
            {
                db.Reports.Add(new ActivityReport 
                { 
                    ActivityId = activityId,
                    WorkerUserName = _currentUserName, 
                    HoursWorked = 0,
                    Date = DateTime.Today, 
                    ActivityDescription = "Attività accettata da un altro utente."
                });
            }
            user.PendingActivity.Remove(activity);
            db.SaveChanges();
            grdCurrentActivities.DataBind();
            grdPendingActivities.DataBind();
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            ExportToCSV(new List<string>() { _currentUserName });
        }

        public void ExportToCSV(List<string> usersNames)
        {
            List<Activity> activities;
            using (var activityActions = new ActivityActions())
            {
                string name = usersNames.Count == 1 ? usersNames[0] : "Gruppo Utenti";
                Response.AddHeader("content-disposition", string.Format("attachment; filename=ListActivities({0}).csv", name));
                Response.ContentType = "application/text";
                StringBuilder strbldr = new StringBuilder();
                //separting header columns text with comma operator
                strbldr.Append("Utente;Id;Nome Attività;Data Inizio;Data Fine;Ore Di Lavoro;Stato");
                //appending new line for gridview header row
                strbldr.Append("\n");
                foreach (var userName in usersNames)
                {
                    activities = activityActions.GetActivities(userName);
                    foreach (var activity in activities)
                    {
                        strbldr.Append(userName + ';');
                        strbldr.Append(activity.ActivityId.ToString() + ';');
                        strbldr.Append(activity.ActivityName + ';');
                        strbldr.Append(activity.StartDate.Value.ToShortDateString() + ';');
                        if (activity.ExpireDate.HasValue)
                            strbldr.Append(activity.ExpireDate.Value.ToShortDateString() + ';');
                        else
                            strbldr.Append("Non definito;");
                        strbldr.Append(activityActions.GetHoursWorked(userName, activity.ActivityId).ToString() + ';');
                        strbldr.Append(activity.Status + ';');
                        strbldr.Append("\n");
                    }
                }
                Response.Write(strbldr.ToString());
                Response.End();
            }
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            grdCurrentActivities.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtDescription.Text = "";
            txtName.Text = "";
            ddlStatus.SelectedValue = "Tutte";
            grdCurrentActivities.DataBind();
        }

        public List<string> PopulateDropDown()
        {
            return new List<string>() { "Tutte", "Da pianificare", "In corso", "Sospese", "Terminate" };
        }
    }
}
