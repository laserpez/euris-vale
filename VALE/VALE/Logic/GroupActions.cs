using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class GroupActions : IDisposable
    {
        UserOperationsContext _db = new UserOperationsContext();
        public bool IsUserRelated(int groupId, string username)
        {
            var group = _db.Groups.FirstOrDefault(g => g.GroupId == groupId);
            return group.Users.Select(u => u.UserName).Contains(username);
        }

        public bool AddUserToGroup(int groupId, string username)
        {
            try
            {
                var group = _db.Groups.FirstOrDefault(g => g.GroupId == groupId);
               
                var userData = _db.UserDatas.FirstOrDefault(u => u.UserName == username);
                if (!group.Users.Contains(userData))
                {
                    group.Users.Add(userData);
                    _db.SaveChanges();
                    return true;
                }
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool AddUsersToGroup(int groupId, List<string>users) 
        {
            try
            {
                var group = _db.Groups.FirstOrDefault(g => g.GroupId == groupId);
                var usersData = _db.UserDatas.Where(u => users.Contains(u.UserName));
                var filteredUsers = usersData.Except(group.Users);
                group.Users.AddRange(filteredUsers);
                _db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool RemoveUserFromGroup(int groupId, string username) 
        {
            try
            {
                var group = _db.Groups.FirstOrDefault(g => g.GroupId == groupId);
                var userData = _db.UserDatas.FirstOrDefault(u => u.UserName == username);
                if (group.Users.Contains(userData))
                {
                    group.Users.Remove(userData);
                    _db.SaveChanges();
                    return true;
                }
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }
    }
}