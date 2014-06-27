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

        public List<T> GetSortedData<T>(string sortExpression, SortDirection direction, List<T> data)
        {
            var result = data.Cast<Event>();

            var param = Expression.Parameter(typeof(Event), sortExpression);
            var sortBy = Expression.Lambda<Func<Event, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (direction == SortDirection.Descending)
                result = result.AsQueryable<Event>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Event>().OrderBy(sortBy).ToList();

            return (List<T>)result;
        }

        public List<T> GetFilteredData<T>(Dictionary<string, string> filters, List<T> data)
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
            var filteredEvents = data.Cast<Event>().Where(ev => ev.EventDate >= fromDate && ev.EventDate <= toDate).ToList();
            return filteredEvents as List<T>;
        }

        public bool AddOrRemoveUserData<T>(T data, UserData user)
        {
            var anEvent = data as Event;
            bool added = false;
            if (!IsUserRelated(anEvent.EventId, user.UserName))
            {
                anEvent.RegisteredUsers.Add(user);
                added = true;
            }
            else
                anEvent.RegisteredUsers.Remove(user);

            return added;
        }

        public bool IsUserRelated(int dataId, string username)
        {
            return _db.Events.First(a => a.EventId == dataId).RegisteredUsers.Select(u => u.UserName).Contains(username);
        }

        public bool RemoveAttachment(int attachmentId)
        {
            try
            {
                var anAttachment = _db.AttachedFiles.FirstOrDefault(at => at.AttachedFileID == attachmentId);
                _db.AttachedFiles.Remove(anAttachment);
                _db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool AddAttachment(int dataId, AttachedFile file)
        {
            try
            {
                var anEvent = _db.Events.First(e => e.EventId == dataId);
                anEvent.AttachedFiles.Add(file);
                _db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public List<AttachedFile> GetAttachments(int dataId)
        {
            var anEvent = _db.Events.First(e => e.EventId == dataId);
            return anEvent.AttachedFiles;
        }


        public bool RemoveAllAttachments(int dataId)
        {
            try
            {
                var anEvent = _db.Events.First(e => e.EventId == dataId);
                var attachments = anEvent.AttachedFiles;
                _db.AttachedFiles.RemoveRange(attachments);
                _db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}