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

        

        public void SetActivityStatus(int id, ActivityStatus status)
        {
            var db = new UserOperationsContext();
            db.Activities.First(a => a.ActivityId == id).Status = status;
            db.SaveChanges();
            logger.Write(new LogEntry() { DataId = id, Username = HttpContext.Current.User.Identity.Name, DataAction = "Modifica stato", DataType = "Attività", Date = DateTime.Now, Description = status.ToString() });
        }

        public int GetActivitiesRequest(string userName)
        {
            var db = new UserOperationsContext();
            return db.UserDatas.First(u => u.UserName == userName).PendingActivity.Count;

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

        public bool AddOrRemoveUserData(int dataId, string username)
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
                added = false;
            }
            db.SaveChanges();
            logger.Write(new LogEntry() { DataId = activity.ActivityId, Username = HttpContext.Current.User.Identity.Name, DataAction = added?"Aggiunto utente":"Rimosso utente", DataType = "Attività", Date = DateTime.Now, Description = username });
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
            var workerUsers = db.Reports.Where(r => r.ActivityId == dataId).Select(r => r.Worker).Distinct().ToList();
            var pendingUsers = db.Activities.First(a => a.ActivityId == dataId).PendingUsers;

            workerUsers.AddRange(pendingUsers);


            return workerUsers.AsQueryable();
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
                logger.Write(new LogEntry() { DataId = newActivity.ActivityId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Creata nuova attività", DataType = "Attività", Date = DateTime.Now, Description = newActivity.ActivityName });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        public bool SaveData<T>(T data)
        {
            throw new NotImplementedException();
        }
    }
}