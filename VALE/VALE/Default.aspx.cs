using System;
using System.Collections.Generic;
using System.Configuration;
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
            this.LogoImage.ImageUrl = ConfigurationManager.AppSettings["LogoVALE"];

            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _db = new UserOperationsContext();
            notLoggedUser.Visible = !HttpContext.Current.User.Identity.IsAuthenticated;
            loggedUser.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
            log.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
            _currentUser = _db.UserDatas.FirstOrDefault(u => u.UserName == User.Identity.Name);
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Home"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina Default.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
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
                return _currentUser.AttendingProjects.OrderByDescending(p => p.LastModified).Take(3).AsQueryable();
            else
                return null;
        }

        public string GetWorkInfo(Project project)
        {
            int hours;
            var projectActions = new ProjectActions();
            hours = projectActions.GetAllProjectHierarchyHoursWorked(project.ProjectId);
            if (project != null)
            {
                int budget = projectActions.GetProjectHierarchyBudget(project.ProjectId);
                if (budget > 0)
                    return String.Format("Budget Totale: {0} Erogato {1}", budget, hours);
            }
            return String.Format(" {0} Ore di lavoro", hours);
        }

        public IQueryable<Event> GetEvents()
        {
            if (_currentUser != null)
                return _currentUser.AttendingEvents.Where(e => e.EventDate >= DateTime.Now).OrderBy(ev => ev.EventDate).Take(3).AsQueryable();
            else
                return null;
        }

        public IQueryable<Activity> GetActivities()
        {
            var actions = new ActivityActions();
            if (_currentUser != null)
                return actions.GetActivities(_currentUser.UserName, ActivityStatus.Ongoing).OrderByDescending(a => a.LastModified).Take(3).AsQueryable();
            else
                return null;
        }
        public string GetWorkInfo(Activity activity)
        {
            var activityActions = new ActivityActions();
            int totalHours = activityActions.GetAllActivityHoursWorked(activity.ActivityId);
            if (activity != null)
                if (activity.Budget > 0)
                    return String.Format("Budget Totale: {0} Erogato {1}", activity.Budget, totalHours);
            return String.Format(" {0} Ore di lavoro", totalHours);
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