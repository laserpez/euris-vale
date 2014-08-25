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
                ComposeMessage(dataId, username, "Un nuovo collaboratore sta partecipando al progetto");
            }
            else
            {
                aProject.InvolvedUsers.Remove(user);
                ComposeMessage(dataId, username, "Rimozione partecipazione");
            }

            aProject.LastModified = DateTime.Now;
            var listHierarchyUp = getHierarchyUp(aProject.ProjectId);
            if (listHierarchyUp.Count != 0)
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

        public void DeletRelatedProject(int projectId, int relatedProjectId)
        {
            var db = new UserOperationsContext();
            var currentProject = db.Projects.First(a => a.ProjectId == projectId);
            var relatedProject = db.Projects.First(a => a.ProjectId == relatedProjectId);
            if (currentProject != null && relatedProject != null) 
            {
                currentProject.RelatedProjects.Remove(relatedProject);
                var listHierarchyUp = getHierarchyUp(currentProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                currentProject.LastModified = DateTime.Now;
                db.SaveChanges();
            }
            //db.Entry(currentProject).Reference(p => p.RelatedProjects).CurrentValue = null;
            
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
                    case "Invito a collaborare ad un progetto":
                        var db = new UserOperationsContext();
                        var aProject = db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var ownerProject = db.UserDatas.FirstOrDefault(u => u.UserName == aProject.OrganizerUserName);
                        if (aProject.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = aProject.InvolvedUsers.ToList();
                            if (listAllUsers.Contains(ownerProject))
                                listAllUsers.Remove(ownerProject);

                            foreach(var anUser in listAllUsers)
                            {
                                var bodyMail =  "Salve, ti informiamo sei stato invitato a collaborare al progetto " + aProject.ProjectName +
                                    ", creato da " + aProject.OrganizerUserName + ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + aProject.ProjectId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Un nuovo collaboratore sta partecipando al progetto":
                        var dbDataContext = new UserOperationsContext();
                        var _project = dbDataContext.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        if (_project.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = _project.InvolvedUsers.ToList();
                            var projectOwner = dbDataContext.UserDatas.FirstOrDefault(u => u.UserName == _project.OrganizerUserName);
                            if (listAllUsers.Contains(projectOwner) == false)
                                listAllUsers.Add(projectOwner);
                            foreach(var anUser in listAllUsers)
                            {
                                var bodyMail = "Salve, ti informiamo al progetto " + _project.ProjectName +
                                    ", creato da " + _project.OrganizerUserName + " sta partecipando anche l'utente " + userName + ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + _project.ProjectId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Aggiunto progetto correlato":
                        var _db = new UserOperationsContext();
                        var OwnerProjectRelated = _db.UserDatas.FirstOrDefault(u => u.UserName == userName);
                        var _aProject = _db.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var aProjectRelated = _aProject.RelatedProjects.Last();
                        var OwnerProject = _db.UserDatas.FirstOrDefault(u => u.UserName == _aProject.OrganizerUserName);
                        if (_aProject.InvolvedUsers.Count != 0 && _aProject.InvolvedUsers.Contains(OwnerProject) == false)
                        {
                            var listAllUsers = _aProject.InvolvedUsers.ToList();
                            foreach(var anUser in listAllUsers)
                            {
                                var bodyMail =  "Salve, ti informiamo che al progetto " + _aProject.ProjectName +
                                    ", creato da " + _aProject.OrganizerUserName + " è stato correlato il progetto " + aProjectRelated.ProjectName + " creato da " + aProjectRelated.OrganizerUserName +
                                    ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + _aProject.ProjectId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        
                        //Invio mail all'owner del progetto correlato
                        var bodyEmail = "Salve, ti informiamo che il tuo progetto " + aProjectRelated.ProjectName + " è stato correlato al progetto " + _aProject.ProjectName + " creato da " + _aProject.OrganizerUserName +  
                            ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + _aProject.ProjectId + "\">Clicca qui<a/>";
                        Mail _newMail = new Mail(to: OwnerProjectRelated.Email, bcc: "", cc: "", subject: subject, body: bodyEmail, form: "Progetto");

                        var _helper = new MailHelper();
                        int _queueId = _helper.AddToQueue(_newMail);
                        _helper.WriteLog(_newMail, _queueId);
                        break;
                    case "Aggiunto documento allegato":
                        var dbData = new UserOperationsContext();
                        var theProject = dbData.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var lastAttachment = theProject.AttachedFiles.Last();
                        if (theProject.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = theProject.InvolvedUsers.ToList();
                            foreach (var anUser in listAllUsers)
                            {
                                var bodyMail = "Salve, ti informiamo che al progetto " + theProject.ProjectName +
                                    ", creato da " + theProject.OrganizerUserName + " è stato allegato il documento " + lastAttachment.FileName + 
                                    ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + theProject.ProjectId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Aggiunta conversazione":
                        var _dbData = new UserOperationsContext();
                        var _theProject = _dbData.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var lastConversation = _theProject.Interventions.Last();
                        if (_theProject.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = _theProject.InvolvedUsers.ToList();
                            foreach (var anUser in listAllUsers)
                            {
                                var bodyMail = "Salve, ti informiamo che al progetto " + _theProject.ProjectName +
                                    ", creato da " + _theProject.OrganizerUserName + " è stata aggiunta una nuova conversazione.<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/InterventionDetails?interventionId=" + lastConversation.InterventionId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Aggiunto commento a conversazione":
                        var _dbDataContext = new UserOperationsContext();
                        var project = _dbDataContext.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var _lastConversation = project.Interventions.Last();
                        if (project.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = project.InvolvedUsers.ToList();
                            foreach (var anUser in listAllUsers)
                            {
                                var bodyMail = "Salve, ti informiamo che ad una conversazione del progetto " + project.ProjectName +
                                    ", creato da " + project.OrganizerUserName + " l'utente " + userName + " ha aggiunto un nuovo commento.<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/InterventionDetails?interventionId=" + _lastConversation.InterventionId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Aggiunto Evento":
                        var contextDB = new UserOperationsContext();
                        var currentProject = contextDB.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var lastEvent = currentProject.Events.Last();
                        if (currentProject.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = currentProject.InvolvedUsers.ToList();
                            foreach (var anUser in listAllUsers)
                            {
                                var bodyMail = "Salve, ti informiamo che al progetto " + currentProject.ProjectName +
                                    ", creato da " + currentProject.OrganizerUserName + " è stata correlato l'evento " + lastEvent.Name +".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + currentProject.ProjectId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Aggiunta Attivita":
                        var _contextDB = new UserOperationsContext();
                        var _currentProject = _contextDB.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var lastActivity = _currentProject.Activities.Last();
                        if (_currentProject.InvolvedUsers.Count != 0)
                        {
                            var listAllUsers = _currentProject.InvolvedUsers.ToList();
                            foreach (var anUser in listAllUsers)
                            {
                                var bodyMail = "Salve, ti informiamo che al progetto " + _currentProject.ProjectName +
                                    ", creato da " + _currentProject.OrganizerUserName + " è stata correlata l'attività " + lastActivity.ActivityName + ".<br/> Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/ProjectDetails?projectId=" + _currentProject.ProjectId + "\">Clicca qui<a/>";
                                Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Progetto");

                                var helper = new MailHelper();
                                int queueId = helper.AddToQueue(newMail);
                                helper.WriteLog(newMail, queueId);
                            }
                        }
                        break;
                    case "Rimozione partecipazione":
                        var contextDb = new UserOperationsContext();
                        var selectedProject = contextDb.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        if (selectedProject.OrganizerUserName != userName)
                        {
                            var owner = contextDb.UserDatas.FirstOrDefault(u => u.UserName == selectedProject.OrganizerUserName);
                            var Mailbody = "Salve, ti informiamo che l'utente " + userName +
                                    " ha rimosso la propria partecipazione dal tuo progetto " + selectedProject.ProjectName;
                            Mail aMail = new Mail(to: owner.Email, bcc: "", cc: "", subject: subject, body: Mailbody, form: "Progetto");

                            var aHelper = new MailHelper();
                            int aQueueId = aHelper.AddToQueue(aMail);
                            aHelper.WriteLog(aMail, aQueueId);
                        }
                        break;
                    case "Cancellazione progetto":
                        var _contextDb = new UserOperationsContext();
                        var deletedProject = _contextDb.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var _projectOwner = _contextDb.UserDatas.FirstOrDefault(u => u.UserName == userName);
                        var _Mailbody = "Salve, ti informiamo che il tuo progetto " + deletedProject.ProjectName +
                                    " è stato cancellato dall'Amministratore";
                        Mail _aMail = new Mail(to: _projectOwner.Email, bcc: "", cc: "", subject: subject, body: _Mailbody, form: "Progetto");

                        var _aHelper = new MailHelper();
                        int _aQueueId = _aHelper.AddToQueue(_aMail);
                        _aHelper.WriteLog(_aMail, _aQueueId);
                        break;
                    case "Sospensione progetto":
                        var dbContext = new UserOperationsContext();
                        var _selectedProject = dbContext.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var _bodyMail = "Salve, ti informiamo che il progetto " + _selectedProject.ProjectName +
                                    ", creato da " + _selectedProject.OrganizerUserName + " è stato sospeso.";

                        SendToCoworkers(_selectedProject, subject, _bodyMail);
                        break;
                    case "Ripreso progetto":
                        var _dbContext = new UserOperationsContext();
                        var _exsospededProject = _dbContext.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var _bodyEMail = "Salve, ti informiamo che il progetto " + _exsospededProject.ProjectName +
                                    ", creato da " + _exsospededProject.OrganizerUserName + " precedentemente sospeso, è stato ora ripreso.";

                        SendToCoworkers(_exsospededProject, subject, _bodyEMail);
                        break;
                    case "Chiusura progetto":
                        var ContextdbData = new UserOperationsContext();
                        var _closedProject = ContextdbData.Projects.FirstOrDefault(p => p.ProjectId == dataId);
                        var bodyEmailToAll = "Salve, ti informiamo che il progetto " + _closedProject.ProjectName +
                                    ", creato da " + _closedProject.OrganizerUserName + " è stato chiuso.";

                        SendToCoworkers(_closedProject, subject, bodyEmailToAll);
                        break;
                }

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        private void SendToCoworkers(Project project, string subject, string mailBody)
        {
            var dbContext = new UserOperationsContext();
            var ownerSelectedProject = dbContext.UserDatas.FirstOrDefault(u => u.UserName == project.OrganizerUserName);
            if (project.InvolvedUsers.Count != 0)
            {
                var listAllUsers = project.InvolvedUsers.ToList();
                if (listAllUsers.Contains(ownerSelectedProject))
                    listAllUsers.Remove(ownerSelectedProject);

                foreach (var anUser in listAllUsers)
                {
                    Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: mailBody, form: "Progetto");

                    var helper = new MailHelper();
                    int queueId = helper.AddToQueue(newMail);
                    helper.WriteLog(newMail, queueId);
                }
            }
        }
    }
}