using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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

        //private void CheckEndDate(Activity activity)
        //{
        //    if (activity.ExpireDate.HasValue)
        //    {
        //        if (activity.ExpireDate.Value <= DateTime.Now)
        //            activity.Status = ActivityStatus.Ended;
        //    }
        //}

        //private void CheckStartDate(Activity activity)
        //{
        //    if (activity.StartDate <= DateTime.Now)
        //        activity.Status = ActivityStatus.Ongoing;
        //}

        public int GetActivitiesRequest(string userName)
        {
            return _db.UsersData.First(u => u.UserName == userName).PendingActivity.Count;

        }

    }
}