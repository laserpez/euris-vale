using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE
{
    public partial class _Default : Page
    {
        private UserData _currentUser;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            notLoggedUser.Visible = !HttpContext.Current.User.Identity.IsAuthenticated;
            loggedUser.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
            log.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
            _currentUser = _db.UserDatas.FirstOrDefault(u => u.UserName == User.Identity.Name);
        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string uri = String.Format("/MyVale/{0}.aspx", btn.CommandArgument);
            Response.Redirect(uri);

        }

        public IQueryable<Project> GetProjects()
        {
            if (_currentUser != null)
                return _currentUser.AttendingProjects.Take(10).AsQueryable();
            else
                return null;
        }

        public IQueryable<Event> GetEvents()
        {
            if (_currentUser != null)
                return _currentUser.AttendingEvents.Take(10).AsQueryable();
            else
                return null;
        }

        public IQueryable<Activity> GetActivities()
        {
            var actions = new ActivityActions();
            if (_currentUser != null)
                return actions.GetActivities(_currentUser.UserName, ActivityStatus.Ongoing).AsQueryable();
            else
                return null;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string uri = String.Format("/MyVale/{0}", btn.CommandArgument);
            Response.Redirect(uri);
        }

        public IQueryable<LogEntry> GetLogEntry()
        {
            var db = new UserOperationsContext();
            return db.LogEntries.OrderByDescending(e => e.Date);
        }

        protected void lstProgetti_DataBound(object sender, EventArgs e)
        {
            //for (int i = 0; i < lstProgetti.Items.Count; i++)
            //{
            //    int projectId = (int)lstProgetti.DataKeys[i].Value;
            //    var db = new UserOperationsContext();

            //    Label lblContent = (Label)lstProgetti.Items[i].FindControl("lblContent");
            //    string projectDescription = db.Projects.Where(p => p.ProjectId == projectId).Select(pr => pr.Description).FirstOrDefault();
            //    var textToSee = projectDescription.Length >= 30 ? projectDescription.Substring(0, 30) + "..." : projectDescription;
            //    lblContent.Text = textToSee;
            //}
        }

        protected void lstEvents_DataBound(object sender, EventArgs e)
        {
            //for (int i = 0; i < lstEvents.Items.Count; i++)
            //{
            //    int eventId = (int)lstEvents.DataKeys[i].Value;
            //    var db = new UserOperationsContext();

            //    Label lblContentEvent = (Label)lstEvents.Items[i].FindControl("lblContentEvent");
            //    string eventDescription = db.Events.FirstOrDefault(ev => ev.EventId == eventId).Description;
            //    var textToSee = eventDescription.Length >= 30 ? eventDescription.Substring(0, 30) + "..." : eventDescription;
            //    lblContentEvent.Text = textToSee;
            //}
        }

        protected void lstActivities_DataBound(object sender, EventArgs e)
        {
            //for (int i = 0; i < lstActivities.Items.Count; i++)
            //{
            //    int activityId = (int)lstActivities.DataKeys[i].Value;
            //    var db = new UserOperationsContext();

            //    Label lblContentActivity = (Label)lstActivities.Items[i].FindControl("lblContentActivity");
            //    string activityDescription = db.Activities.FirstOrDefault(ac => ac.ActivityId == activityId).Description;
            //    var textToSee = activityDescription.Length >= 30 ? activityDescription.Substring(0, 30) + "..." : activityDescription;
            //    lblContentActivity.Text = textToSee;
            //}
        }
       

        
        
    }
}