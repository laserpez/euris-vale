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
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                db.SaveChanges();

                ComposeMessage(dataId, "", "Aggiunto documento allegato");

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
                if (listHierarchyUp.Count != 0)
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


        public bool AddOrRemoveUserData(int dataId, string username, string requestForm)
        {
            var db = new UserOperationsContext();
            var aProject = db.Projects.First(p => p.ProjectId == dataId);
            var user = db.UserDatas.FirstOrDefault(u => u.UserName == username);
            bool added = false;
            string subject = String.Empty;
            if (!IsUserRelated(aProject.ProjectId, username))
            {
                aProject.InvolvedUsers.Add(user);
                added = true;
                subject = "Richiesta partecipazione ad un Progetto";
            }
            else
            {
                aProject.InvolvedUsers.Remove(user);
                subject = "Rimozione partecipazione";
            }

            aProject.LastModified = DateTime.Now;
            var listHierarchyUp = getHierarchyUp(aProject.ProjectId);
            if (listHierarchyUp.Count != 0)
                listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
            db.SaveChanges();
            if (requestForm == "creator")
                ComposeMessage(dataId, "", "Invito di partecipazione ad un Progetto");
            else
                ComposeMessage(dataId, username, subject);
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

        public void DeletRelatedProject(int projectId, int relatedProjectId)
        {
            var db = new UserOperationsContext();
            var currentProject = db.Projects.First(a => a.ProjectId == projectId);
            var relatedProject = db.Projects.First(a => a.ProjectId == relatedProjectId);
            if (currentProject != null && relatedProject != null) 
            {
                ComposeMessage(projectId, relatedProject.OrganizerUserName, "Rimosso progetto correlato");
                currentProject.RelatedProjects.Remove(relatedProject);
                var listHierarchyUp = getHierarchyUp(currentProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                currentProject.LastModified = DateTime.Now;
                db.SaveChanges();
            }
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
                    var father = db.Projects.FirstOrDefault(p => p.RelatedProjects.FirstOrDefault(r => r.ProjectId == project.ProjectId) != null);
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
                    var father = db.Projects.FirstOrDefault(p => p.RelatedProjects.FirstOrDefault(r => r.ProjectId == project.ProjectId) != null);
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
            list.AddRange(project.RelatedProjects);
            project.RelatedProjects.ForEach(p => list.AddRange(getHierarchyDown(p.ProjectId)));
            return list;
        }

        public bool HasFather(Project project)
        {
            var db = new UserOperationsContext();
            var father = db.Projects.FirstOrDefault(p => p.RelatedProjects.FirstOrDefault(r => r.ProjectId == project.ProjectId) != null);
            if (father != null)
                return true;
            return false;
        }

        public Project GetFather(Project project)
        {
            var db = new UserOperationsContext();
            var father = db.Projects.FirstOrDefault(p => p.RelatedProjects.FirstOrDefault(r => r.ProjectId == project.ProjectId) != null);
            return father;
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

        public bool ComposeMessage(int dataId, string userName, string subject)
        {
            try
            {
                switch (subject)
                {
                    case "Invito di partecipazione ad un Progetto":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            if (IsUserRelated(dataId, aProject.OrganizerUserName))
                            {
                                var owner = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName);
                                registeredUsers.Remove(owner);
                            }
                            if (registeredUsers.Count != 0)
                            {
                                var bodyMail = "Salve, ti informiamo sei stato invitato a collaborare al progetto " + aProject.ProjectName +
                                        ", creato da " + aProject.OrganizerUserName + ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Richiesta partecipazione ad un Progetto":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            if (userName != aProject.OrganizerUserName)
                            {
                                var bodyMail = "Salve, ti informiamo che l'utente " + userName +
                                            " sta partecipando al tuo progetto " + aProject.ProjectName + ".";
                                var ownerEmail = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName).Email;
                                SendToPrivate(ownerEmail, subject, bodyMail);
                            }
                        }
                        break;
                    case "Rimozione partecipazione":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            if (userName != aProject.OrganizerUserName)
                            {
                                var bodyMail = "Salve, ti informiamo che l'utente " + userName +
                                            " ha rimosso la propria partecipazione dal tuo progetto " + aProject.ProjectName + ".";
                                var ownerEmail = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName).Email;
                                SendToPrivate(ownerEmail, subject, bodyMail);
                            }
                        }
                        break;
                    case "Aggiunto progetto correlato":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            if (IsUserRelated(dataId, aProject.OrganizerUserName))
                            {
                                var owner = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName);
                                registeredUsers.Remove(owner);
                            }
                            var bodyMail = String.Empty;
                            var lastProject = aProject.RelatedProjects.Last();
                            if (registeredUsers.Count != 0)
                            {
                                bodyMail = "Salve, ti informiamo che al progetto " + aProject.ProjectName +
                                        ", creato da " + aProject.OrganizerUserName + " è stato correlato il progetto " + lastProject.ProjectName + " creato da " + lastProject.OrganizerUserName +
                                        ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }

                            //Invio mail all'owner del progetto correlato
                            bodyMail = "Salve, ti informiamo che il tuo progetto " + lastProject.ProjectName + " è stato correlato al progetto " + aProject.ProjectName + " creato da " + aProject.OrganizerUserName +
                                ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui</a>.";
                            var userEmail = db.UserDatas.FirstOrDefault(u => u.UserName == userName).Email;
                            SendToPrivate(userEmail, subject, bodyMail);
                        }
                        break;
                    case "Rimosso progetto correlato":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var deletedProjects = db.Projects.Where(p => p.OrganizerUserName == userName).ToList();
                            Project deletedProject = null;
                            foreach (var project in deletedProjects)
                            {
                                if (GetFather(project) == aProject)
                                    deletedProject = project;
                            }
                            var bodyMail = "Salve, ti informiamo che il tuo progetto" + deletedProject.ProjectName + " non è più correlato al progetto " +
                                    aProject.OrganizerUserName + " di " + aProject.OrganizerUserName + ".";
                            var userEmail = db.UserDatas.FirstOrDefault(u => u.UserName == userName).Email;
                            SendToPrivate(userEmail, subject, bodyMail);
                        }
                        break;
                    case "Aggiunto documento allegato":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            
                            if (registeredUsers.Count != 0)
                            {
                                var lastAttachment = aProject.AttachedFiles.Last();
                                var bodyMail = "Salve, ti informiamo che al progetto " + aProject.ProjectName +
                                        ", creato da " + aProject.OrganizerUserName + " è stato allegato il documento " + lastAttachment.FileName +
                                        ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Aggiunta conversazione":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            
                            if (registeredUsers.Count != 0)
                            {
                                var lastConversation = aProject.Interventions.Last();
                                var bodyMail = "Salve, ti informiamo che al progetto " + aProject.ProjectName +
                                        ", creato da " + aProject.OrganizerUserName + " è stata aggiunta una nuova conversazione.<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/InterventionDetails?interventionId=" + lastConversation.InterventionId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Aggiunto commento a conversazione":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            
                            if (registeredUsers.Count != 0)
                            {
                                var lastComment = db.Comments.FirstOrDefault(c => c.CreatorUserName == userName && c.Date.ToShortDateString() == DateTime.Now.ToShortDateString());
                                var bodyMail = "Salve, ti informiamo che ad una conversazione del progetto " + aProject.ProjectName +
                                       ", creato da " + aProject.OrganizerUserName + " l'utente " + userName + " ha aggiunto un nuovo commento.<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/InterventionDetails?interventionId=" + lastComment.InterventionId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Aggiunto Evento":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            
                            if (registeredUsers.Count != 0)
                            {
                                var lastEvent = aProject.Events.Last();
                                var bodyMail = "Salve, ti informiamo che al progetto " + aProject.ProjectName +
                                        ", creato da " + aProject.OrganizerUserName + " è stata correlato l'evento " + lastEvent.Name + ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Aggiunta Attivita":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            
                            if (registeredUsers.Count != 0)
                            {
                                var lastActivity = aProject.Activities.Last();
                                var bodyMail = "Salve, ti informiamo che al progetto " + aProject.ProjectName +
                                        ", creato da " + aProject.OrganizerUserName + " è stata correlato l'evento " + lastActivity.ActivityName + ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui</a>.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Cancellazione progetto":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var bodyMail = "Salve, ti informiamo che il tuo progetto " + aProject.ProjectName +
                                " è stato cancellato dall'Amministratore. Per maggiori informazioni contattare l'Amministratore.";
                            var userEmail = db.UserDatas.FirstOrDefault(u => u.UserName == userName).Email;
                            SendToPrivate(userEmail, subject, bodyMail);
                        }
                        break;
                    case "Sospensione progetto":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            if (IsUserRelated(dataId, aProject.OrganizerUserName))
                            {
                                var owner = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName);
                                registeredUsers.Remove(owner);
                            }
                            if (registeredUsers.Count != 0)
                            {
                                var bodyMail = "Salve, ti informiamo che il progetto " + aProject.ProjectName +
                                    ", creato da " + aProject.OrganizerUserName + " è stato sospeso.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Ripresa progetto":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            if (IsUserRelated(dataId, aProject.OrganizerUserName))
                            {
                                var owner = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName);
                                registeredUsers.Remove(owner);
                            }
                            if (registeredUsers.Count != 0)
                            {
                                var bodyMail = "Salve, ti informiamo che il progetto " + aProject.ProjectName +
                                    ", creato da " + aProject.OrganizerUserName + " precedentemente sospeso, è stato ora ripreso.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                    case "Chiusura progetto":
                        if (dataId != 0)
                        {
                            var db = new UserOperationsContext();
                            var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                            var registeredUsers = aProject.InvolvedUsers.ToList();
                            if (IsUserRelated(dataId, aProject.OrganizerUserName))
                            {
                                var owner = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName);
                                registeredUsers.Remove(owner);
                            }
                            if (registeredUsers.Count != 0)
                            {
                                var bodyMail = "Salve, ti informiamo che il progetto " + aProject.ProjectName +
                                    ", creato da " + aProject.OrganizerUserName + " è stato chiuso.";
                                SendToCoworkers(subject, bodyMail, registeredUsers);
                            }
                        }
                        break;
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        private void SendToPrivate(string userMail, string subject, string bodyMail)
        {
            Mail newMail = new Mail(to: userMail, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");
            AddToQueue(newMail);
        }

        private void SendToCoworkers(string subject, string mailBody, List<UserData> listAllUsers)
        {
            foreach (var anUser in listAllUsers)
            {
                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: mailBody, form: "Progetto");
                AddToQueue(newMail);
            }
        }

        private void AddToQueue(Mail email)
        {
            var helper = new MailHelper();
            int queueId = helper.AddToQueue(email);
            helper.WriteLog(email, queueId);
        }


        public bool IsStartedWork(string username)
        {
            return false;
        }
    }
}