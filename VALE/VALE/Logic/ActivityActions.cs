using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public class ActivityActions : IActions
    {
        public ILogger logger { get; set; }

        public ActivityActions()
        {
            logger = LogFactory.GetCurrentLogger();
        }

        /// <summary>
        /// Gets the activities.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="status">The status.</param>
        /// <returns></returns>
        public List<Activity> GetActivities(string userName, ActivityStatus status)
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerUserName == userName).GroupBy(r => r.ActivityId).Select(gr => gr.Key).ToList();
            return db.Activities.Where(a => activitiesId.Contains(a.ActivityId) && a.Status == status).ToList();
        }

        public List<Activity> GetActivities(string userName)
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerUserName == userName).GroupBy(r => r.ActivityId).Select(gr => gr.Key).ToList();
            return db.Activities.Where(a => activitiesId.Contains(a.ActivityId)).ToList();
        }

        public int GetHoursWorked(string userName, int activityId)
        {
            var db = new UserOperationsContext();
            return db.Reports.Where(r => r.ActivityId == activityId && r.WorkerUserName == userName).Sum(r => r.HoursWorked);
        }

        public int GetAllActivityHoursWorked(int activityId)
        {
            var db = new UserOperationsContext();
            var reports = db.Reports.Where(r => r.ActivityId == activityId);
            if (reports != null && reports.Count() > 0)
                return reports.Sum(r => r.HoursWorked);
            else
                return 0;
        }

        public void SetActivityStatus(int id, ActivityStatus status)
        {
            var db = new UserOperationsContext();
            var anActivity = db.Activities.First(a => a.ActivityId == id);
            db.Activities.First(a => a.ActivityId == id).Status = status;
            anActivity.LastModified = DateTime.Today;

            if (anActivity.RelatedProject != null)
            {
                anActivity.RelatedProject.LastModified = DateTime.Today;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(anActivity.RelatedProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);
            }

            db.SaveChanges();

            if (anActivity.Status == ActivityStatus.Done)
                ComposeMessage(anActivity.ActivityId, "", "Terminazione attività");

            logger.Write(new LogEntry() { DataId = id, Username = HttpContext.Current.User.Identity.Name, DataAction = "Modifica stato attività", DataType = "Attività", Date = DateTime.Today, Description = "\"" + anActivity.ActivityName + "\"" + " ha ora lo stato: " + status.ToString() });
        }

        
        public int GetActivitiesRequest(string userName)
        {
            var db = new UserOperationsContext();
            var pendingActivity = db.UserDatas.First(u => u.UserName == userName).PendingActivity;
            if (pendingActivity != null)
                return pendingActivity.Count;
            return 0;
        }


        public string GetStatus(Activity anActivity)
        {
            if (anActivity.Status == ActivityStatus.ToBePlanned)
                return "Da pianificare";
            if (anActivity.Status == ActivityStatus.Suspended)
                return "Sospesa";
            if (anActivity.Status == ActivityStatus.Ongoing)
                return "In corso";
            if (anActivity.Status == ActivityStatus.Done)
                return "Terminata";
            if (anActivity.Status == ActivityStatus.Deleted)
                return "Cancellata";

            return null;
        }

        internal IQueryable<Activity> GetCurrentActivities(string txtName, string txtDescription, string ddlStatus, string currentUserName)
        {
            var db = new UserOperationsContext();
            var activitiesId = db.Reports.Where(r => r.WorkerUserName == currentUserName).Select(r => r.ActivityId);
            var activities = db.Activities.Where(a => activitiesId.Contains(a.ActivityId));
            if (txtName != null)
                activities = activities.Where(a => a.ActivityName.ToUpper().Contains(txtName.ToUpper()));
            if (txtDescription != null)
                activities = activities.Where(a => a.Description.ToUpper().Contains(txtDescription.ToUpper()));
            if (ddlStatus != null && ddlStatus != "Tutte")
            {
                ActivityStatus statusFilter = ActivityStatus.Deleted;
                switch (ddlStatus)
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

        internal IQueryable<Activity> GetPendingActivities(string currentUserName)
        {
            var db = new UserOperationsContext();
            return db.UserDatas.First(u => u.UserName == currentUserName).PendingActivity.AsQueryable();
        }

        internal List<ActivityReport> Sort(SortDirection GridViewSortDirection, List<ActivityReport> result, string sortExpression)
        {
            var param = Expression.Parameter(typeof(ActivityReport), sortExpression);
            var sortBy = Expression.Lambda<Func<ActivityReport, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                return result = result.AsQueryable<ActivityReport>().OrderByDescending(sortBy).ToList();
            else
                return result = result.AsQueryable<ActivityReport>().OrderBy(sortBy).ToList();
        }


        public bool AddOrRemoveUserData(int dataId, string username, string requestform)
        {
            var db = new UserOperationsContext();
            var activity = db.Activities.First(a => a.ActivityId == dataId);
            var user = db.UserDatas.First(u => u.UserName == username);
            bool added = false;
            if(!IsUserRelated(dataId,username))
            {
                activity.PendingUsers.Add(user);
                added = true;
            }
            else
            {
                activity.PendingUsers.Remove(user);
                var intervention = db.Reports.FirstOrDefault(r => r.WorkerUserName == user.UserName);
                if (intervention == null)
                    activity.RegisteredUsers.Remove(user);
                added = false;
            }
            if (activity.RelatedProject != null)
            {
                activity.RelatedProject.LastModified = DateTime.Today;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(activity.RelatedProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);
            }
            activity.LastModified = DateTime.Today;
            db.SaveChanges();
            logger.Write(new LogEntry() { DataId = activity.ActivityId, Username = HttpContext.Current.User.Identity.Name, DataAction = added ? "Invitato utente" : "Rimosso utente", DataType = "Attività", Date = DateTime.Today, Description = username + (added ? " è stato invitato all'attività \"" : " non collabora più all'attività \"") + activity.ActivityName + "\"" });
            return added;
        }

        public bool IsUserRelated(int dataId, string username)
        {
            var db = new UserOperationsContext();
            var user = db.UserDatas.First(u => u.UserName == username);
            var related = GetRelatedUsers(dataId);

            return related.Contains(user);
        }

        public bool IsGroupRelated(int dataId, int groupId)
        {
            var db = new UserOperationsContext();
            var group = db.Groups.First(g => g.GroupId == groupId);
            var result = true;
            foreach(var user in group.Users)
            {
                if (!IsUserRelated(dataId, user.UserName))
                {
                    result = false;
                    break;
                }
            }
            return result;
        }

        public IQueryable<UserData> GetRelatedUsers(int dataId)
        {
            var db = new UserOperationsContext();
            //var workerUsers = db.Reports.Where(r => r.ActivityId == dataId).Select(r => r.Worker).Distinct().ToList();
            var pendingUsers = db.Activities.First(a => a.ActivityId == dataId).PendingUsers;
            pendingUsers.AddRange(db.Activities.First(a => a.ActivityId == dataId).RegisteredUsers);
            //workerUsers.AddRange(pendingUsers);
            //return workerUsers.AsQueryable();
            return pendingUsers.AsQueryable();
        }

        public IQueryable<Group> GetRelatedGroups(int dataId)
        {
            var result = new List<Group>();
            var db = new UserOperationsContext();
            foreach (var group in db.Groups)
            {
                if (IsGroupRelated(dataId, group.GroupId))
                    result.Add(group);
            }
            return result.AsQueryable();
        }


        public bool SaveData<T>(T data, UserOperationsContext db)
        {
            try
            {
                var newActivity = data as Activity;
                db.Activities.Add(newActivity);
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = newActivity.ActivityId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Creata nuova attività", DataType = "Attività", Date = DateTime.Today, Description = "E' stata creata la nuova attività \"" + newActivity.ActivityName + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        internal void AddOrRefusePendingActivity(int activityId, bool accept)
        {
            var db = new UserOperationsContext();
            var activity = db.Activities.First(a => a.ActivityId == activityId);
            var user = db.UserDatas.First(u => u.UserName == HttpContext.Current.User.Identity.Name);
            if (accept == true)
            {
                //db.Reports.Add(new ActivityReport
                //{
                //    ActivityId = activityId,
                //    WorkerUserName = user.UserName,
                //    HoursWorked = 0,
                //    Date = DateTime.Today,
                //    ActivityDescription = "Attività ricevuta da un altro utente."
                //});
                user.AttendingActivities.Add(activity);
            }
            logger.Write(new LogEntry() { DataId = activity.ActivityId, Username = HttpContext.Current.User.Identity.Name, DataAction = accept ? "Accettato attività" : "Rifiutato attività", DataType = "Attività", Date = DateTime.Today, Description = user.UserName + (accept ? " partecipa ora all'attività \"" : " non ha accettato di partecipare all'attività \"") + activity.ActivityName + "\"" });
            user.PendingActivity.Remove(activity);
            db.SaveChanges();
            if (accept == true)
            {
                ComposeMessage(activityId, "", "Aggiunto intervento");
                ComposeMessage(activityId, user.UserName, "Conferma collaborazione");
            }
            else
                ComposeMessage(activityId, user.UserName, "Rifiuto collaborazione");
        }

        public bool ComposeMessage(int dataId, string userName, string subject)
        {
            try
            {
                switch (subject)
                {
                    case "Invito di partecipazione ad una Attività":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            var pendingUsers = anActivity.PendingUsers.ToList();
                            if (IsUserRelated(dataId, anActivity.CreatorUserName))
                            { 
                                var owner = db.UserDatas.FirstOrDefault(u => u.UserName == anActivity.CreatorUserName);
                                pendingUsers.Remove(owner);
                            }
                            if (pendingUsers.Count != 0)
                            {
                                var bodyMail = "Sei stato invitato a collaborare all'attività " + anActivity.ActivityName +
                                    ", creata da " + anActivity.CreatorUserName + ".<br/>Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ActivityDetails?activityId=" + anActivity.ActivityId + "\">Clicca qui</a>";

                                SendToCoworkers(subject, bodyMail, pendingUsers);
                            }
                        }
                        break;
                    case "Conferma collaborazione":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            if (userName != anActivity.CreatorUserName)
                            {
                                var bodyMail = "L'utente " + userName + " ha confermato la propria partecipazione alla tua attività " + anActivity.ActivityName + ".";
                                var ownerEmail = db.UserDatas.FirstOrDefault(u => u.UserName == anActivity.CreatorUserName).Email;
                                SendToPrivate(ownerEmail, subject, bodyMail);
                            }
                        }
                        break;
                    case "Rifiuto collaborazione":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            if (userName != anActivity.CreatorUserName)
                            {
                                var bodyMail = "L'utente " + userName + " ha rifiutato di partecipare alla tua attività " + anActivity.ActivityName + ".";
                                var ownerEmail = db.UserDatas.FirstOrDefault(u => u.UserName == anActivity.CreatorUserName).Email;
                                SendToPrivate(ownerEmail, subject, bodyMail);
                            }
                        }
                        break;
                    case "Aggiunto intervento":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            var registeredUsers = anActivity.RegisteredUsers.ToList();

                            if (registeredUsers.Count != 0)
                            {
                                var bodyMail = "All'attività " + anActivity.ActivityName + ", di " + anActivity.CreatorUserName +
                                    " è stato aggiunto un nuovo intervento.<br/>Per maggiori informazioni clicca sulla <a href=\" http://localhost:59959/MyVale/ActivityDetails?activityId=" + anActivity.ActivityId + "\">pagina di dettaglio</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Aggiunto progetto correlato":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            var relatedProject = anActivity.RelatedProject;
                            var registeredUsers = anActivity.RegisteredUsers.ToList();

                            var bodyMail = String.Empty;

                            if (registeredUsers.Count != 0)
                            {
                                bodyMail = "All'attività " + anActivity.ActivityName + " è stato correlato il progetto " + relatedProject.ProjectName + " creato da " + relatedProject.OrganizerUserName +
                                    ".<br/>Per maggiori informazioni clicca sulla <a href=\" http://localhost:59959/MyVale/ActivityDetails?activityId=" + anActivity.ActivityId + "\">pagina di dettaglio</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }

                            //Invio e-mail ai partecipanti del progetto corelato
                            var projectActions = new ProjectActions();
                            projectActions.ComposeMessage(relatedProject.ProjectId, "", "Aggiunta Attivita");

                            //Invio mail all'owner del progetto correlato
                            bodyMail = "Il tuo progetto " + relatedProject.ProjectName + " è stato correlato all'attività " + anActivity.ActivityName + " creato da " + anActivity.CreatorUserName +
                                ".<br/> Per maggiori informazioni clicca  sulla <a href=\" http://localhost:59959/MyVale/ActivityDetails?activityId=" + anActivity.ActivityId + "\">pagina di dettaglio</a>.";
                            var userEmail = db.UserDatas.FirstOrDefault(u => u.UserName == userName).Email;
                            SendToPrivate(userEmail, subject, bodyMail);
                        }
                        break;
                    case "Rimozione progetto correlato":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            var lastProject = anActivity.RelatedProject;
                            var bodyMail = "Il tuo progetto" + lastProject.ProjectName + " non è più correlato all'evento " +
                                    anActivity.ActivityName + " di " + anActivity.CreatorUserName + ".";
                            var userEmail = db.UserDatas.FirstOrDefault(u => u.UserName == userName).Email;
                            SendToPrivate(userEmail, subject, bodyMail);
                        }
                        break;
                    case "Terminazione attività":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var anActivity = db.Activities.FirstOrDefault(a => a.ActivityId == dataId);
                            var registeredUsers = anActivity.RegisteredUsers.ToList();
                            if (registeredUsers.Count != 0)
                            {
                                var bodyMail = "L'attività " + anActivity.ActivityName + ", di " + anActivity.CreatorUserName + " è stata conclusa.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                                if (anActivity.RelatedProject != null)
                                {
                                    var projectRegisteredUsers = db.Projects.FirstOrDefault(p => p.ProjectId == anActivity.ProjectId).InvolvedUsers.ToList();
                                    SendToCoworkers(subject, bodyMail, projectRegisteredUsers);
                                }
                            }
                        }
                        break;
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        private void SendToPrivate(string userMail, string subject, string bodyMail)
        {
            Mail newMail = new Mail(to: userMail, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Attivita");
            AddToQueue(newMail);
        }

        private void SendToCoworkers(string subject, string mailBody, List<UserData> listAllUsers)
        {
            foreach (var anUser in listAllUsers)
            {
                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: mailBody, form: "Attivita");
                AddToQueue(newMail);
            }
        }

        private void AddToQueue(Mail email)
        {
            var helper = new MailHelper();
            int queueId = helper.AddToQueue(email);
            helper.WriteLog(email, queueId);
        }


        public bool IsStartedWork(string username)
        {
            var db = new UserOperationsContext();
            var intervention = db.Reports.FirstOrDefault(r => r.WorkerUserName == username);
            return intervention != null;
        }
    }
}