using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public class ProjectActions : IDisposable
    {
        UserOperationsContext _db = new UserOperationsContext();

        public List<Project> GetSortedData(string property, List<Project> projects, SortDirection direction)
        {
            var result = projects;

            var param = Expression.Parameter(typeof(Project), property);
            var sortBy = Expression.Lambda<Func<Project, object>>(Expression.Convert(Expression.Property(param, property), typeof(object)), param);

            if (direction == SortDirection.Descending)
                result = result.AsQueryable<Project>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Project>().OrderBy(sortBy).ToList();
            
            return result;
        }


        public List<Project> GetFilteredData( Dictionary<string, string> filters, List<Project> projects)
        {
            var result = projects;
            foreach(var filter in filters)
            {
                switch(filter.Key)
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
            return result;

        }



        public void AddOrRemoveUser(int projectId, string userName)
        {
            var project = _db.Projects.First(p => p.ProjectId == projectId);
            var user =_db.UsersData.First(u => u.UserName == userName);
            if (IsUserRelated(projectId, userName))
            {
                project.InvolvedUsers.Remove(user);
                user.AttendingProjects.Remove(project);
            }
            else
            {
                project.InvolvedUsers.Add(user);
                user.AttendingProjects.Add(project);
            }
            _db.SaveChanges();

        }

        public bool IsUserRelated(int projectId, string userName)
        {
            var project = _db.Projects.First(p => p.ProjectId == projectId);
            return project.InvolvedUsers.Select(u => u.UserName).Contains(userName);
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }
    }
}