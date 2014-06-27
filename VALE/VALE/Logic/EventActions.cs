using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public class EventActions : IDisposable, IActions
    {
        UserOperationsContext _db = new UserOperationsContext();

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }

        public EventActions(){}

        public List<Event> GetSortedData(string sortExpression, SortDirection direction, List<Event> events)
        {
            var result = events;

            var param = Expression.Parameter(typeof(Event), sortExpression);
            var sortBy = Expression.Lambda<Func<Event, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (direction == SortDirection.Descending)
                result = result.AsQueryable<Event>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Event>().OrderBy(sortBy).ToList();

            return result;
        }

        public List<Event> GetFilteredData(Dictionary<string, string> filters, List<Event> events)
        {
            var fromDateStr = "";
            var toDateStr = "";

            foreach (var aFilter in filters)
            {
                switch (aFilter.Key)
                {
                    case "fromDate":
                        fromDateStr = aFilter.Value;
                        break;
                    case "toDate":
                        toDateStr = aFilter.Value;
                        break;
                }
            }
            var fromDate = DateTime.Parse(fromDateStr);
            var toDate = DateTime.Parse(toDateStr);
            var filteredEvents = events.Where(ev => ev.EventDate >= fromDate && ev.EventDate <= toDate);
            return filteredEvents.ToList();
        }

        public bool IsUserAttendingThisEvent(int eventId, string currentUser)
        {
            return _db.Events.First(a => a.EventId == eventId).RegisteredUsers.Select(u => u.UserName).Contains(currentUser);
        }

        public bool AddOrRemoveUser(Event anEvent, UserData currentUser)
        {
            bool added = false;
            if (!IsUserAttendingThisEvent(anEvent.EventId, currentUser.UserName))
            {
                anEvent.RegisteredUsers.Add(currentUser);
                added = true;
            }
            else
                anEvent.RegisteredUsers.Remove(currentUser);

            return added;
        }

        public List<Event> GetAllEvents()
        {
            return _db.Events.ToList();
        }
    }
}