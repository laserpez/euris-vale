using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class PersonalActivities : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
        }

        protected void ddlSelectActivity_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        public List<Activity> GetPersonalActivities()
        {
            var db = new UserOperationsContext();
            var activityIds = db.Reports.Where(r => r.WorkerId == _currentUserId).GroupBy(r => r.ActivityId).Select(o => o.Key);
            return db.Activities.Where(a => activityIds.Contains(a.ActivityId)).ToList();
            
        }

        protected void bnViewReports_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var activityId = Convert.ToInt32(ddlSelectActivity.SelectedValue);
            var reports = db.Reports
                .Where(r => r.WorkerId == _currentUserId && r.ActivityId == activityId)
                .OrderByDescending(r => r.ActivityReportId).ToList();
            grdActivityReport.DataSource = reports;
            grdActivityReport.DataBind();

        }
    }
}