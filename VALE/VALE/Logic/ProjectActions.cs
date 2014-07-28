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
                var projectId = anAttachment.RelatedProject.ProjectId;
                var aProject = db.Projects.Where(p => p.ProjectId == projectId).FirstOrDefault();
                aProject.AttachedFiles.Remove(anAttachment);
                db.AttachedFiles.Remove(anAttachment);
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
                var actions = new ProjectActions();
                var listHierarchyUp = getHierarchyUp(project.ProjectId);
                listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
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
                var listHierarchyUp = getHierarchyUp(project.ProjectId);
                listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
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
            aProject.LastModified = DateTime.Now;
            var listHierarchyUp = getHierarchyUp(aProject.ProjectId);
            listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
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

        public void DeletRelatedProject(int projectId)
        {
            var db = new UserOperationsContext();
            var currentProject = db.Projects.First(a => a.ProjectId == projectId);
            db.Entry(currentProject).Reference(p => p.RelatedProject).CurrentValue = null;
            var listHierarchyUp = getHierarchyUp(currentProject.ProjectId);
            listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
            currentProject.LastModified = DateTime.Now;
            
            db.SaveChanges();
        }

        public List<Project> getHierarchyUp(int projectId)
        {
            var db = new UserOperationsContext();
            List<Project> list = new List<Project>();
            var project = db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            if (project != null)
            {
                var hasNext = true;
                while (hasNext)
                {
                    var father = db.Projects.FirstOrDefault(p => p.RelatedProject.ProjectId == project.ProjectId);
                    if (father != null)
                    {
                        list.Add(father);
                        project = father;
                    }
                    else
                        hasNext = false;
                }
            }
            return list;
        }

        public int getRootId(int projectId)
        {
            var db = new UserOperationsContext();
            int rootId = 0;
            var project = db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            if (project != null)
            {
                var hasNext = true;
                while (hasNext)
                {
                    var father = db.Projects.FirstOrDefault(p => p.RelatedProject.ProjectId == project.ProjectId);
                    if (father != null)
                    {
                        rootId = father.ProjectId;
                        project = father;
                    }
                    else
                        hasNext = false;
                }
            }
            return rootId;
        }

        public List<Project> getHierarchyDown(int projectId)
        {
            var db = new UserOperationsContext();
            List<Project> list = new List<Project>();
            var project = db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            while(project.RelatedProject != null)
            {
                list.Add(project.RelatedProject);
                project = project.RelatedProject;
            }
            return list;
        }

        public bool HasFather(Project project)
        {
            var db = new UserOperationsContext();
            var father = db.Projects.FirstOrDefault(p => p.RelatedProject.ProjectId == project.ProjectId);
            if (father != null)
                return true;
            return false;
        }

        public List<Project> GetCompatibleProjects(int projectId)
        {
            var db = new UserOperationsContext();
            List<Project> list = new List<Project>();
            var projects = db.Projects.Where(pr => pr.Status != "Chiuso" && pr.ProjectId != projectId).ToList();
            var rootId = getRootId(projectId);
            foreach (var project in projects)
            {
                if (!HasFather(project) && project.ProjectId != rootId)
                    list.Add(project);
            }
            return list;
        }

        public int GetAllProjectHoursWorked(Project project) 
        {
            int total = 0;
            ActivityActions activityActions = new ActivityActions();
            foreach (var activity in project.Activities)
	        {
                total += activityActions.GetAllActivityHoursWorked(activity.ActivityId);
	        }
            return total;
        }

        public int GetAllProjectHierarchyHoursWorked(int projectId)
        {
            int total = 0;
            var db = new UserOperationsContext();
            var rootProject = db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            total = GetAllProjectHoursWorked(rootProject);
            var projects = getHierarchyDown(projectId);
            foreach (var project in projects)
            {
                total += GetAllProjectHoursWorked(project);
            }
            return total;
        }

        public int GetProjectHierarchyBudget(int projectId)
        {
            int total = 0;
            var db = new UserOperationsContext();
            var rootProject = db.Projects.FirstOrDefault(p => p.ProjectId == projectId);
            total = rootProject.Budget;
            var projects = getHierarchyDown(projectId);
            foreach (var project in projects)
            {
                total += project.Budget;
            }
            return total;
        }
    }
}