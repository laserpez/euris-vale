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
            {
                var projectsList = new List<Project>();
                var allAttendingProjects = _currentUser.AttendingProjects;
                foreach (var project in allAttendingProjects)
                {
                    if (project.RelatedProject != null)
                    {
                        if (project.RelatedProject.LastModified.Date <= DateTime.Now.Date)
                            projectsList.Add(project);
                    }
                    else if (project.LastModified.Date <= DateTime.Now.Date)
                        projectsList.Add(project);
                }
                return projectsList.Take(3).AsQueryable();
            }
            else
                return null;
        }

        public IQueryable<Event> GetEvents()
        {
            if (_currentUser != null)
            {
                var allAttendingEvents = _currentUser.AttendingEvents;
                var attendingEvents = new List<Event>();
                foreach (var anEvent in allAttendingEvents)
                {
                    if (anEvent.RelatedProject != null)
                    {
                        if (anEvent.RelatedProject.LastModified.Date <= DateTime.Now.Date)
                            attendingEvents.Add(anEvent);
                    }
                    else if (anEvent.EventDate.Date <= DateTime.Now.Date)
                        attendingEvents.Add(anEvent);
                }
                foreach()
                return attendingEvents.OrderByDescending(e => e.RelatedProject.LastModified).OrderByDescending(ev => ev.EventDate).Take(3).AsQueryable();
            }
            else
                return null;
        }

        public IQueryable<Activity> GetActivities()
        {
            var actions = new ActivityActions();
            if (_currentUser != null)
            {
                var allOnGoingActivities = actions.GetActivities(_currentUser.UserName, ActivityStatus.Ongoing);
                var onGoingActivities = new List<Activity>();
                foreach(var activity in allOnGoingActivities)
                {
                    if (activity.RelatedProject != null)
                    {
                        if (activity.RelatedProject.LastModified.Date <= DateTime.Now.Date)
                            onGoingActivities.Add(activity);
                    }
                    else if (activity.LastModified.Date <= DateTime.Now)
                        onGoingActivities.Add(activity);
                }
                return onGoingActivities.OrderByDescending(a => a.RelatedProject.LastModified).OrderByDescending(ac => ac.LastModified).Take(3).AsQueryable();
            }
            else
                return null;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string uri = String.Format("/MyVale/{0}&From=/Default", btn.CommandArgument);
            Response.Redirect(uri);
        }

        public IQueryable<LogEntry> GetLogEntry()
        {
            var db = new UserOperationsContext();
            return db.LogEntries.OrderByDescending(e => e.Date);
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
    }
}