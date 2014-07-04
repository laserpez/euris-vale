using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    [Serializable]
    public class EventActions : IFileActions, IActions
    {
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
            try
            {
                var fromDate = DateTime.Parse(fromDateStr);
                var toDate = DateTime.Parse(toDateStr);
                var filteredEvents = data.Cast<Event>().Where(ev => ev.EventDate >= fromDate && ev.EventDate <= toDate).ToList();
                return filteredEvents as List<T>;
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public bool IsUserRelated(int dataId, string username)
        {
            var _db = new UserOperationsContext();
            return _db.Events.First(a => a.EventId == dataId).RegisteredUsers.Select(u => u.UserName).Contains(username);
        }

        public bool RemoveAttachment(int attachmentId)
        {
            try
            {
                var _db = new UserOperationsContext();
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
                var _db = new UserOperationsContext();
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
            var _db = new UserOperationsContext();
            var anEvent = _db.Events.First(e => e.EventId == dataId);
            return anEvent.AttachedFiles;
        }


        public bool RemoveAllAttachments(int dataId)
        {
            try
            {
                var _db = new UserOperationsContext();
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


        public IQueryable<UserData> GetRelatedUsers(int dataId)
        {
            var _db = new UserOperationsContext();
            var anEvent = _db.Events.First(e => e.EventId == dataId);
            return anEvent.RegisteredUsers.AsQueryable();
        }


        public bool AddOrRemoveUserData(int dataId, string username)
        {
            var _db = new UserOperationsContext();
            var anEvent = _db.Events.First(e => e.EventId == dataId);
            var user = _db.UserDatas.FirstOrDefault(u => u.UserName == username);
            bool added = false;
            if (!IsUserRelated(anEvent.EventId, username))
            {   
                anEvent.RegisteredUsers.Add(user);
                added = true;
            }
            else
                anEvent.RegisteredUsers.Remove(user);
            _db.SaveChanges();
            return added;
        }


        public IQueryable<Group> GetRelatedGroups(int _dataId)
        {
            var db = new UserOperationsContext();
            var groups = db.Groups;
            List<Group> result = new List<Group>();
            foreach (var group in groups)
            {
                if (IsGroupRelated(_dataId, group.GroupId))
                    result.Add(group);
            }
            return result.AsQueryable();
        }


        public bool IsGroupRelated(int dataId, int groupId)
        {
            var db = new UserOperationsContext();
            var anEvent = db.Events.First(e => e.EventId == dataId);
            var group = db.Groups.First(g => g.GroupId == groupId);

            var usersRelated = anEvent.RegisteredUsers;

            return group.Users.Join(usersRelated, g => g.UserName, u => u.UserName, (g, u) => g.UserName + " " + u.UserName).Count() == group.Users.Count;
        }
    }
}