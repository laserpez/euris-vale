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

        public List<Activity> GetConcludedActivities(string userName)
        {
            var userId = GetUserId(userName);
            var activitiesId = _db.Reports.Where(r => r.WorkerId == userId).GroupBy(r => r.ActivityId).Select(gr => gr.Key).ToList();
            return _db.Activities.Where(a => activitiesId.Contains(a.ActivityId)).ToList();
        }

        public int GetHoursWorked(string userName, int activityId)
        {
            var userId = GetUserId(userName);
            return _db.Reports.Where(r => r.ActivityId == activityId && r.WorkerId == userId).Sum(r => r.HoursWorked);
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }

        public string GetUserId(string userName)
        {
            var _dbUser = new ApplicationDbContext();
            return _dbUser.Users.First(u => u.UserName == userName).Id;
        }
    }
}