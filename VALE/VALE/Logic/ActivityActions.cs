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
    public class ActivityActions : IDisposable
    {
        UserOperationsContext _db = new UserOperationsContext();

        public List<Activity> GetActivities(string userName, ActivityStatus status)
        {
            var activitiesId = _db.Reports.Where(r => r.WorkerUserName == userName).GroupBy(r => r.ActivityId).Select(gr => gr.Key).ToList();
            return _db.Activities.Where(a => activitiesId.Contains(a.ActivityId) && a.Status == status).ToList();
        }

        public List<Activity> GetActivities(string userName)
        {
            var activitiesId = _db.Reports.Where(r => r.WorkerUserName == userName).GroupBy(r => r.ActivityId).Select(gr => gr.Key).ToList();
            return _db.Activities.Where(a => activitiesId.Contains(a.ActivityId)).ToList();
        }

        public int GetHoursWorked(string userName, int activityId)
        {
            return _db.Reports.Where(r => r.ActivityId == activityId && r.WorkerUserName == userName).Sum(r => r.HoursWorked);
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }

        public void SetActivityStatus(int id, ActivityStatus status)
        {
            _db.Activities.First(a => a.ActivityId == id).Status = status;
            _db.SaveChanges();
        }

        public int GetActivitiesRequest(string userName)
        {
            return _db.UserDatas.First(u => u.UserName == userName).PendingActivity.Count;

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

        public void ChangeStatusClick(string statusString, int currentActivityId)
        {
            var activity = _db.Activities.First(a => a.ActivityId == currentActivityId);
            ActivityStatus newStatus;
            Enum.TryParse(statusString, out newStatus);
            activity.Status = newStatus;
            _db.SaveChanges();
        }

        internal IQueryable<Activity> GetCurrentActivities(string txtName, string txtDescription, string ddlStatus, string currentUserName)
        {
            var activitiesId = _db.Reports.Where(r => r.WorkerUserName == currentUserName).Select(r => r.ActivityId);
            var activities = _db.Activities.Where(a => activitiesId.Contains(a.ActivityId));
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
            return _db.UserDatas.First(u => u.UserName == currentUserName).PendingActivity.AsQueryable();
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
    }
}