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

        public List<Activity> GetConcludedActivities(string userId)
        {
            var activitiesId = _db.Reports.Where(r => r.WorkerId == userId).GroupBy(r => r.ActivityId).Select(gr => gr.Key).ToList();
            return _db.Activities.Where(a => activitiesId.Contains(a.ActivityId)).ToList();
        }

        public string GetHoursWorked(string userId, int activityId)
        {
            return _db.Reports.Where(r => r.ActivityId == activityId && r.WorkerId == userId).Sum(r => r.HoursWorked).ToString();
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }
    }
}