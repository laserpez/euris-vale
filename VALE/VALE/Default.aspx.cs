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
                return String.Format("{0} Erogato {1}", budget, hours);
            }
            return "";
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
                return String.Format("{0} Erogato {1}", activity.Budget, totalHours);
            return "";
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string uri = String.Format("/MyVale/{0}&From=/Default", btn.CommandArgument);
            Response.Redirect(uri);
        }

        public string GetDescription(string description)
        {
            if (!String.IsNullOrEmpty(description))
            {
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(description);
                description = doc.DocumentNode.InnerText;
                //if (description.Contains("Per maggiori informazioni"))
                //    description = Clean(description);
                return description;
            }
            else
            {
                return "Nessuna descrizione presente";
            }
        }

        public IQueryable<LogEntryEmail> grdLog_GetData()
        {
            var listLogsToShow = new List<LogEntryEmail>();

            var db = new UserOperationsContext();
            var allMailUser = db.LogEntriesEmail.Where(u => u.Receiver == _currentUser.Email && u.Read == false).ToList();
            if (allMailUser.Count != 0)
            {
                var allMailRegisters = allMailUser.Where(m => m.DataType == "Registrazione").ToList();
                var allMailProjects = allMailUser.Where(m => m.DataType == "Progetto" && (m.DataAction == "Invito di partecipazione ad un Progetto" || m.DataAction == "Invito di partecipazione ad un Progetto" || m.DataAction == "Richiesta partecipazione ad un Progetto" || m.DataAction == "Rimozione partecipazione")).ToList();
                var allMailEvents = allMailUser.Where(m => m.DataType == "Evento" && (m.DataAction == "Invito di partecipazione ad un Evento" || m.DataAction == "Richiesta partecipazione ad un Evento" || m.DataAction == "Rimozione partecipazione")).ToList();
                var allMailActivities = allMailUser.Where(m => m.DataType == "Attivita" && (m.DataAction == "Invito a collaborare ad una Attività" || m.DataAction == "Conferma collaborazione" || m.DataAction == "Rifiuto collaborazione")).ToList();

                if (allMailRegisters.Count != 0)
                {
                    listLogsToShow.AddRange(allMailRegisters);
                    allMailUser.RemoveRange(0, allMailRegisters.Count);
                }

                if (allMailProjects.Count != 0)
                {
                    listLogsToShow.AddRange(allMailProjects);
                    allMailUser.RemoveRange(0, allMailProjects.Count);
                }

                if (allMailEvents.Count != 0)
                {
                    listLogsToShow.AddRange(allMailEvents);
                    allMailUser.RemoveRange(0, allMailEvents.Count);
                }

                if (allMailActivities.Count != 0)
                {
                    listLogsToShow.AddRange(allMailActivities);
                    allMailUser.RemoveRange(0, allMailActivities.Count);
                }

                if (allMailUser.Count != 0)
                    listLogsToShow.AddRange(allMailUser);
            }

            return listLogsToShow.AsQueryable();
        }

        protected void selectedMessage_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();

            for (int i = 0; i < grdLog.Rows.Count; i++)
            {
                CheckBox chkBox = (CheckBox)grdLog.Rows[i].Cells[0].FindControl("chkSelectMessage");
                if (chkBox.Checked)
                {
                    var logEntryEmailId = Convert.ToInt32(grdLog.DataKeys[i].Value);
                    var log = db.LogEntriesEmail.FirstOrDefault(l => l.LogEntryEmailId == logEntryEmailId);
                    log.Read = true;
                    db.SaveChanges();
                }
            }
            grdLog.DataBind();
        }
    }
}