﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public class ProjectActions : IDisposable, IActions
    {
        UserOperationsContext _db = new UserOperationsContext();

        public List<T> GetSortedData<T>(string sortExpression, SortDirection direction, List<T> data)
        {
            var result = data.Cast<Project>();

            var param = Expression.Parameter(typeof(Project), sortExpression);
            var sortBy = Expression.Lambda<Func<Project, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (direction == SortDirection.Descending)
                result = result.AsQueryable<Project>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Project>().OrderBy(sortBy).ToList();

            return (List<T>)result;
        }

        public List<T> GetFilteredData<T>(Dictionary<string, string> filters, List<T> data)
        {
            var result = data.Cast<Project>();
            foreach (var filter in filters)
            {
                switch (filter.Key)
                {
                    case "Name":
                        result = result.Where(p => p.ProjectName.ToLower().Contains(filter.Value.ToLower())).ToList();
                        break;
                    case "Description":
                        result = result.Where(p => p.Description.ToLower().Contains(filter.Value.ToLower())).ToList();
                        break;
                    case "CreationDate":
                        result = result.Where(p => p.CreationDate.ToShortDateString() == filter.Value).ToList();
                        break;
                    case "LastModifiedDate":
                        result = result.Where(p => p.LastModified.ToShortDateString() == filter.Value).ToList();
                        break;
                    case "ProjectStatus":
                        result = result.Where(p => p.Status.ToUpper() == filter.Value.ToUpper()).ToList();
                        break;
                    default:
                        break;
                }
            }
            return (List<T>)result;
        }

        public bool IsUserRelated(int projectId, string userName)
        {
            var project = _db.Projects.First(p => p.ProjectId == projectId);
            return project.InvolvedUsers.Select(u => u.UserName).Contains(userName);
        }

        public bool AddOrRemoveUserData<T>(T data, UserData user)
        {
            var project = data as Project;
            if (IsUserRelated(project.ProjectId, user.UserName))
            {
                project.InvolvedUsers.Remove(user);
                user.AttendingProjects.Remove(project);
                return false;
            }
            else
            {
                project.InvolvedUsers.Add(user);
                user.AttendingProjects.Add(project);
                return true;
            }
        }

        public bool AddAttachment(int attachmentId)
        {
            throw new NotImplementedException();
        }

        public bool RemoveAttachment(int attachmentId)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }
    }
}