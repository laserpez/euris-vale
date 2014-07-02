using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class GroupActions
    {
        public bool IsUserRelated(int groupId, string username)
        {
            var db = new UserOperationsContext();
            var group = db.Groups.FirstOrDefault(g => g.GroupId == groupId);
            return group.Users.Select(u => u.UserName).Contains(username);
        }

        public bool AddUserToGroup(int groupId, string username)
        {
            try
            {
                var db = new UserOperationsContext();
                var group = db.Groups.FirstOrDefault(g => g.GroupId == groupId);
                var userData = db.UserDatas.FirstOrDefault(u => u.UserName == username);
                if (!group.Users.Contains(userData))
                {
                    group.Users.Add(userData);
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
                var db = new UserOperationsContext();
                var group = db.Groups.FirstOrDefault(g => g.GroupId == groupId);
                var usersData = db.UserDatas.Where(u => users.Contains(u.UserName));
                var filteredUsers = usersData.Except(group.Users);
                group.Users.AddRange(filteredUsers);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool RemoveUserToGroup(int groupId, string username) 
        {
            try
            {
                var db = new UserOperationsContext();
                var group = db.Groups.FirstOrDefault(g => g.GroupId == groupId);
                var userData = db.UserDatas.FirstOrDefault(u => u.UserName == username);
                if (!group.Users.Contains(userData))
                {
                    group.Users.Remove(userData);
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
    }
}