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
    public partial class UserActivities : System.Web.UI.Page
    {
        private int _activityId;
        private string _userEmail;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.HasKeys())
            {
                _activityId = Convert.ToInt32(Request.QueryString.GetValues("activityId").First());
                _userEmail = Request.QueryString.GetValues("userId").First();
            }
        }

        public IQueryable<ActivityReport> GetUserActivities([QueryString("activityId")] int? activityId, [QueryString("userId")] string userEmail)
        {
            var db = new UserOperationsContext();
            if (activityId.HasValue && !String.IsNullOrEmpty(userEmail))
            {
                return db.Reports.Where(r => r.Worker.Email == userEmail && r.ActivityId == activityId);
            }
            else
                return null;
        }

        public string GetWorkerName()
        {
            var db = new UserOperationsContext();
            return db.UsersData.First(u => u.Email == _userEmail).FullName;
        }

        public string GetWorkedActivity()
        {
            var db = new UserOperationsContext();
            return db.Activities.First(a => a.ActivityId == _activityId).ActivityName;
        }

        protected void grdReports_DataBound(object sender, EventArgs e)
        {
            lblSummary.Text = String.Format("Report for user {0} on activity {1}", GetWorkerName(), GetWorkedActivity());
        }


    }
}