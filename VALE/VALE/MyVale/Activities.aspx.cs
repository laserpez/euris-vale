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

namespace VALE.MyVale
{
    public partial class Activities : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
        }

        public IQueryable<Activity> GetCurrentActivities()
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerId == _currentUserId).Select(r => r.ActivityId);
            var activities = db.Activities.Where(a => activitiesId.Contains(a.ActivityId));
            return activities;
        }

        public IQueryable<Activity> GetPendingActivities()
        {
            var db = new UserOperationsContext();
            var activities = db.UsersData.First(u => u.UserDataId == _currentUserId).PendingActivity.AsQueryable();
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
                int activityId = Convert.ToInt32(grdCurrentActivities.Rows[index].Cells[0].Text);
                Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
            }

        }

        protected void grdPendingActivities_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int activityId = Convert.ToInt32(grdPendingActivities.Rows[index].Cells[0].Text);
            var db = new UserOperationsContext();
            var activity = db.Activities.First(a => a.ActivityId == activityId);
            var user = db.UsersData.First(u => u.UserDataId == _currentUserId);
            if (e.CommandName == "AcceptActivity")
            {
                db.Reports.Add(new ActivityReport 
                { 
                    ActivityId = activityId, 
                    WorkerId = _currentUserId, 
                    HoursWorked = 0,
                    Date = DateTime.Today, 
                    ActivityDescription = "Accepted activity from another user"
                });
            }
            user.PendingActivity.Remove(activity);
            db.SaveChanges();
            grdCurrentActivities.DataBind();
            grdPendingActivities.DataBind();
        }


        // TODO va cambiato ovviamente, intanto testo così
        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerId == _currentUserId).Select(r => r.ActivityId);
            var activities = db.Activities.Where(a => activitiesId.Contains(a.ActivityId));
            using (StreamWriter streamWriter = new StreamWriter(Server.MapPath("data.csv")))
            {
                var csv = new CsvWriter(streamWriter);
                foreach (var activity in activities)
                {
                    csv.WriteField(activity.ActivityId);
                    csv.WriteField(activity.ActivityName);
                    csv.WriteField(activity.Description);
                    csv.WriteField(activity.CreationDate);
                    csv.WriteField(activity.ExpireDate);
                    csv.WriteField(activity.Status);
                    csv.NextRecord();
                }
            }
        }       
    }
}
