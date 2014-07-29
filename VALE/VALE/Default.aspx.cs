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
                var attendingProjetsTemp = new List<Project>();
                var attendingProjects = new List<Project>();
                var allAttendingProjects = _currentUser.AttendingProjects;
                List<DateTime> allDates = new List<DateTime>();
                foreach (var aProject in allAttendingProjects)
                {
                    if (aProject.RelatedProject != null)
                    {
                        if (aProject.RelatedProject.LastModified.Date <= DateTime.Now.Date)
                        {
                            attendingProjetsTemp.Add(aProject);
                            allDates.Add(aProject.RelatedProject.LastModified.Date);
                        }
                    }
                    else if (aProject.LastModified.Date <= DateTime.Now.Date)
                    {
                        attendingProjetsTemp.Add(aProject);
                        allDates.Add(aProject.LastModified.Date);
                    }
                }
                allDates = allDates.OrderByDescending(o => o.Date).Distinct().ToList();

                foreach (var date in allDates)
                {
                    foreach (var aProject in attendingProjetsTemp)
                    {
                        if (aProject.RelatedProject != null)
                        {
                            if (aProject.RelatedProject.LastModified.Date == date)
                                attendingProjects.Add(aProject);
                        }
                        else if (aProject.LastModified.Date == date)
                            attendingProjects.Add(aProject);
                    }
                }

                return attendingProjects.Take(3).AsQueryable();
            }
            else
                return null;
        }

        public IQueryable<Event> GetEvents()
        {
            if (_currentUser != null)
            {
                var allAttendingEvents = _currentUser.AttendingEvents;
                var attendingEventsTemp = new List<Event>();
                var attendingEvents = new List<Event>();
                List<DateTime> allDates = new List<DateTime>();
                foreach (var anEvent in allAttendingEvents)
                {
                    if (anEvent.RelatedProject != null)
                    {
                        if (anEvent.RelatedProject.LastModified.Date <= DateTime.Now.Date)
                        {
                            attendingEventsTemp.Add(anEvent);
                            allDates.Add(anEvent.RelatedProject.LastModified.Date);
                        }
                    }
                    else if (anEvent.EventDate.Date <= DateTime.Now.Date)
                    {
                        attendingEventsTemp.Add(anEvent);
                        allDates.Add(anEvent.EventDate.Date);
                    }
                }

                allDates = allDates.OrderByDescending(o => o.Date).Distinct().ToList();

                foreach (var date in allDates)
                {
                    foreach (var anEvent in attendingEventsTemp)
                    {
                        if (anEvent.RelatedProject != null)
                        {
                            if (anEvent.RelatedProject.LastModified.Date == date)
                                attendingEvents.Add(anEvent);
                        }
                        else if (anEvent.EventDate.Date == date)
                            attendingEvents.Add(anEvent);
                    }
                }

                return attendingEvents.Take(3).AsQueryable();
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
                var onGoingActivitiesTemp = new List<Activity>();
                var allDates = new List<DateTime>();

                foreach(var anActivity in allOnGoingActivities)
                {
                    if (anActivity.RelatedProject != null)
                    {
                        if (anActivity.RelatedProject.LastModified.Date <= DateTime.Now.Date)
                        {
                            onGoingActivitiesTemp.Add(anActivity);
                            allDates.Add(anActivity.RelatedProject.LastModified.Date);
                        }
                    }
                    else if (anActivity.LastModified.Date <= DateTime.Now)
                    {
                        onGoingActivitiesTemp.Add(anActivity);
                        allDates.Add(anActivity.LastModified);
                    }
                }

                allDates = allDates.OrderByDescending(o => o.Date).Distinct().ToList();

                foreach (var date in allDates)
                {
                    foreach (var anActivity in onGoingActivitiesTemp)
                    {
                        if (anActivity.RelatedProject != null)
                        {
                            if (anActivity.RelatedProject.LastModified.Date == date)
                                onGoingActivities.Add(anActivity);
                        }
                        else if (anActivity.LastModified.Date == date)
                            onGoingActivities.Add(anActivity);
                    }
                }

                return onGoingActivities.Take(3).AsQueryable();
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