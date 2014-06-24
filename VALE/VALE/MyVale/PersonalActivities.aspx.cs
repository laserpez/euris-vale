using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using System.Web.UI.WebControls;
using VALE.Models;
using System.Linq.Expressions;

namespace VALE.MyVale
{
    public partial class PersonalActivities : System.Web.UI.Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();

            if (!IsPostBack)
            {
                ViewState["lstActivities"] = new List<ActivityReport>();
                PopulateDropDownList();
            }

        }

        private void PopulateDropDownList()
        {
            var listPersonalActivities = GetPersonalActivities();
            if (listPersonalActivities.Count == 0)
            {
                SelectLabel.Text = "Non sono attualmente presenti attività di cui poter vedere il report.";
                ddlSelectActivity.Visible = false;
                bnViewReports.Visible = false;
            }
            else
            {
                SelectLabel.Text = "Seleziona l'attività per vedere il report personale";
                ListItem init = new ListItem();
                init.Text = "Seleziona";
                ddlSelectActivity.Items.Add(init);
                foreach (var aPersonalActivity in listPersonalActivities)
                {
                    ListItem li = new ListItem();
                    li.Value = aPersonalActivity.ActivityId.ToString();
                    li.Text = aPersonalActivity.ActivityName;
                    ddlSelectActivity.Items.Add(li);
                }
            }
        }

        public List<Activity> GetPersonalActivities()
        {
            var db = new UserOperationsContext();
            var activityIds = db.Reports.Where(r => r.WorkerUserName == _currentUser).GroupBy(r => r.ActivityId).Select(o => o.Key);
            return db.Activities.Where(a => activityIds.Contains(a.ActivityId)).ToList();
        }

        protected void bnViewReports_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();

            if (ddlSelectActivity.SelectedIndex == 0)
            {
                // Reload the page.
                string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                Response.Redirect(pageUrl);
            }
            else
            {
                var activityId = Convert.ToInt32(ddlSelectActivity.SelectedValue);
                List<ActivityReport> reports = new List<ActivityReport>();
                reports = db.Reports.Where(r => r.WorkerUserName == _currentUser && r.ActivityId == activityId).OrderByDescending(r => r.ActivityReportId).ToList();
                grdActivityReport.DataSource = reports;
                ViewState["lstActivities"] = reports;
                grdActivityReport.DataBind();
            }
        }

        public SortDirection GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] == null)
                    ViewState["sortDirection"] = SortDirection.Ascending;

                return (SortDirection)ViewState["sortDirection"];
            }
            set { ViewState["sortDirection"] = value; }
        }

        protected void grdActivityReport_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            grdActivityReport.DataSource = GetSortedData(e.SortExpression);
            grdActivityReport.DataBind();
        }

        private List<ActivityReport> GetSortedData(string sortExpression)
        {
            var result = (List<ActivityReport>)ViewState["lstActivities"];

            var param = Expression.Parameter(typeof(ActivityReport), sortExpression);
            var sortBy = Expression.Lambda<Func<ActivityReport, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                result = result.AsQueryable<ActivityReport>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<ActivityReport>().OrderBy(sortBy).ToList();
            ViewState["llstActivities"] = result;
            return result;
        }
    }
}