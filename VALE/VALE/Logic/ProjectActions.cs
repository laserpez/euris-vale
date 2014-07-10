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
    public class ProjectActions : IActions, IFileActions
    {
        public ILogger logger { get; set; }

        public ProjectActions()
        {
            logger = LogFactory.GetCurrentLogger();

        }

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
            var db = new UserOperationsContext();
            var project = db.Projects.First(p => p.ProjectId == projectId);
            return project.InvolvedUsers.Select(u => u.UserName).Contains(userName);
        }

        public bool RemoveAttachment(int attachmentId)
        {
            try
            {
                var db = new UserOperationsContext();
                var anAttachment = db.AttachedFiles.FirstOrDefault(at => at.AttachedFileID == attachmentId);
                db.AttachedFiles.Remove(anAttachment);
                anAttachment.RelatedProject.LastModified = DateTime.Now;
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = anAttachment.RelatedProject.ProjectId, Username = HttpContext.Current.User.Identity.Name, DataAction = "E' stato rimosso il documento \"" + anAttachment.RelatedProject.ProjectName + "\"", DataType = "Progetto", Date = DateTime.Now, Description = "Nome documento: \"" + anAttachment.FileName + "\"" });
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
                var db = new UserOperationsContext();
                var project = db.Projects.First(p => p.ProjectId == dataId);
                project.AttachedFiles.Add(file);
                project.LastModified = DateTime.Now;
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = project.ProjectId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Aggiunto documento a \"" + project.ProjectName + "\"", DataType = "Progetto", Date = DateTime.Now, Description = "Nome documento: \"" + file.FileName + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public List<AttachedFile> GetAttachments(int dataId)
        {
            var db = new UserOperationsContext();
            var project = db.Projects.First(p => p.ProjectId == dataId);
            return project.AttachedFiles;
        }

        public bool RemoveAllAttachments(int dataId)
        {
            try
            {
                var db = new UserOperationsContext();
                var project = db.Projects.First(p => p.ProjectId == dataId);
                db.AttachedFiles.RemoveRange(project.AttachedFiles);
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = dataId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Rimossi tutti i documenti", DataType = "Progetto", Date = DateTime.Now, Description = "Rimossi tutti i documenti da \"" + project.ProjectName + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public IQueryable<UserData> GetRelatedUsers(int dataId)
        {
            var db = new UserOperationsContext();
            var project = db.Projects.First(p => p.ProjectId == dataId);
            return project.InvolvedUsers.AsQueryable(); 
        }


        public bool AddOrRemoveUserData(int dataId, string username)
        {
            var db = new UserOperationsContext();
            var aProject = db.Projects.First(p => p.ProjectId == dataId);
            var user = db.UserDatas.FirstOrDefault(u => u.UserName == username);
            bool added = false;
            if (!IsUserRelated(aProject.ProjectId, username))
            {
                aProject.InvolvedUsers.Add(user);
                added = true;
            }
            else
                aProject.InvolvedUsers.Remove(user);
            db.SaveChanges();

            logger.Write(new LogEntry() { DataId = dataId, Username = user.UserName, DataAction = added ? "Aggiunto utente" : "Rimosso utente", DataType = "Progetto", Date = DateTime.Now, Description = user.UserName + (added ? " è stato invitato al progetto \"" : " non collabora più al progetto \"") + aProject.ProjectName + "\"" });
            return added;
        }

        public IQueryable<Group> GetRelatedGroups(int dataId)
        {
            var db = new UserOperationsContext();
            var result = new List<Group>();
            foreach(var group in db.Groups)
            {
                if (IsGroupRelated(dataId, group.GroupId))
                    result.Add(group);
            }
            return result.AsQueryable();
        }

        public bool IsGroupRelated(int dataId, int groupId)
        {
            var db = new UserOperationsContext();
            var group = db.Groups.First(g => g.GroupId == groupId);
            var usersRelated = GetRelatedUsers(dataId);
            return group.Users.Join(usersRelated, g => g.UserName, u => u.UserName, (g, u) => g.UserName + " " + u.UserName).Count() == group.Users.Count;
        }


        public bool SaveData<T>(T data, UserOperationsContext db)
        {
            try
            {
                var project = data as Project;
                db.Projects.Add(project);
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = project.ProjectId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Creato nuovo progetto", DataType = "Progetto", Date = DateTime.Now, Description ="E' stato creato il nuovo progetto \"" + project.ProjectName + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}