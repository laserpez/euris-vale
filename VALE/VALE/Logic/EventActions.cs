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
        public ILogger logger { get; set; }

        public EventActions()
        {
            logger = LogFactory.GetCurrentLogger();
        }

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
            catch (Exception)
            {
                return null;
            }
        }

        public bool SaveData<T>(T data, UserOperationsContext db)
        {
            try
            {
                var newEvent = data as Event;
                
                db.Events.Add(newEvent);
                if (newEvent.RelatedProject != null)
                {
                    newEvent.RelatedProject.LastModified = DateTime.Now;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(newEvent.RelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = newEvent.EventId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Creato nuovo evento", DataType = "Evento", Date = DateTime.Now, Description = "E' stato creato il nuovo evento \"" + newEvent.Name + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
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
                var eventId = anAttachment.RelatedEvent.EventId;
                var anEvent = _db.Events.Where(ev => ev.EventId == eventId).First();
                anEvent.AttachedFiles.Remove(anAttachment);
                _db.AttachedFiles.Remove(anAttachment);
                if (anEvent.RelatedProject != null)
                {
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(anEvent.RelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
                _db.SaveChanges();
                logger.Write(new LogEntry() { DataId = eventId, Username = HttpContext.Current.User.Identity.Name, DataAction = "E' stato rimosso il documento \"" + anAttachment.RelatedEvent.Name + "\"", DataType = "Evento", Date = DateTime.Now, Description = "Nome documento: \"" + anAttachment.FileName + "\"" });
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
                if (anEvent.RelatedProject != null)
                {
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(anEvent.RelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
                _db.SaveChanges();
                logger.Write(new LogEntry() { DataId = anEvent.EventId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Aggiunto documento a \"" + anEvent.Name + "\"", DataType = "Evento", Date = DateTime.Now, Description = "Nome documento: \"" + file.FileName + "\"" });
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
                if (anEvent.RelatedProject != null)
                {
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(anEvent.RelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
                _db.SaveChanges();
                logger.Write(new LogEntry() { DataId = anEvent.EventId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Rimossi tutti i documenti", DataType = "Evento", Date = DateTime.Now, Description = "Rimossi tutti i documenti da \"" + anEvent.Name + "\"" });
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


        public bool AddOrRemoveUserData(int dataId, string username, string requestform)
        {
            var _db = new UserOperationsContext();
            var anEvent = _db.Events.First(e => e.EventId == dataId);
            var user = _db.UserDatas.FirstOrDefault(u => u.UserName == username);
            bool added = false;
            if (!IsUserRelated(anEvent.EventId, username))
            {   
                anEvent.RegisteredUsers.Add(user);
                added = true;
                if (requestform == "creator")
                    ComposeMessage(anEvent.EventId, "", "Invito di partecipazione ad un Evento");
                else
                    ComposeMessage(anEvent.EventId, username, "Richiesta partecipazione ad un Evento");
            }
            else
            {
                anEvent.RegisteredUsers.Remove(user);
                if (requestform == "creator")
                    ComposeMessage(anEvent.EventId, "", "Invito di partecipazione ad un Evento");
                else
                    ComposeMessage(anEvent.EventId, username, "Rimozione partecipazione");
            }

            if (anEvent.RelatedProject != null)
            {
                anEvent.RelatedProject.LastModified = DateTime.Now;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(anEvent.RelatedProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
            }
            _db.SaveChanges();

            logger.Write(new LogEntry() { DataId = anEvent.EventId, Username = HttpContext.Current.User.Identity.Name, DataAction = added ? "Invitato utente" : "Rimosso utente", DataType = "Evento", Date = DateTime.Now, Description = username + (added ? " è stato invitato all'evento \"" : " non collabora più all'evento \"") + anEvent.Name + "\"" });
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

        public bool ComposeMessage(int dataId, string userName, string subject)
        {
            try
            {
                switch (subject)
                {
                    case "Creazione Evento pubblico":
                        var db = new UserOperationsContext();
                        var anEvent = db.Events.FirstOrDefault(ev => ev.EventId == dataId);
                        List<UserData> listAllUsers = db.UserDatas.Where(ev => ev.UserName != anEvent.OrganizerUserName).ToList();
                        if (anEvent.Public == true && listAllUsers.Count != 0)
                        {
                            var bodyMail = "Salve, ti informiamo che in data " + anEvent.EventDate.ToShortDateString() +
                                " si terrà l'evento " + anEvent.Name + ", organizzato da " + anEvent.OrganizerUserName +
                                ", alle ore " + anEvent.EventDate.ToShortTimeString() + " in " + anEvent.Site + ".<br/> L'evento avrà una durata di " + anEvent.Durata + " ore.<br/>"
                                 + "La partecipazione è pubblica.<br/>" +
                                "Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/EventDetails?EventId=" + anEvent.EventId + "\">Clicca qui<a/>";
                            SendToCoworkers(anEvent, subject, bodyMail, listAllUsers);
                        }
                        break;
                    case "Invito di partecipazione ad un Evento":
                        var _db = new UserOperationsContext();
                        var _anEvent = _db.Events.FirstOrDefault(ev => ev.EventId == dataId);
                        if (_anEvent.RegisteredUsers.Count != 0)
                        {
                            var bodyMail = "Salve, ti informiamo che in data " + _anEvent.EventDate.ToShortDateString() +
                                " si terrà l'evento " + _anEvent.Name + ", organizzato da " + _anEvent.OrganizerUserName +
                                ", alle ore " + _anEvent.EventDate.ToShortTimeString() + " in " + _anEvent.Site + ".<br/> L'evento avrà una durata di " + _anEvent.Durata + " ore.<br/>"
                                 + ".<br/>" +
                                "Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/EventDetails?EventId=" + _anEvent.EventId + "\">Clicca qui<a/>";
                            SendToCoworkers(_anEvent, subject, bodyMail, _anEvent.RegisteredUsers);
                        }
                        break;
                    case "Richiesta partecipazione ad un Evento":
                        var dbData = new UserOperationsContext();
                        var theEvent = dbData.Events.FirstOrDefault(ev => ev.EventId == dataId);
                        if (userName != theEvent.OrganizerUserName)
                        {
                            var bodyMail = "Salve, ti informiamo che l'utente " + userName + " ha rimosso la propria partecipazione dal tuo evento "
                                + theEvent.Name;
                            var owner = dbData.UserDatas.FirstOrDefault(u => u.UserName == theEvent.OrganizerUserName);
                            Mail newMail = new Mail(to: owner.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Evento");
                            AddToQueue(newMail);
                        }
                        break;
                    case "Rifiuto partecipazione ad un Evento":
                        var _dbData = new UserOperationsContext();
                        var _theEvent = _dbData.Events.FirstOrDefault(ev => ev.EventId == dataId);
                        if (userName != _theEvent.OrganizerUserName)
                        {
                            var bodyMail = "Salve, ti informiamo che l'utente " + userName + " ha rimosso la propria partecipazione dal tuo evento "
                                + _theEvent.Name;
                            var owner = _dbData.UserDatas.FirstOrDefault(u => u.UserName == _theEvent.OrganizerUserName);
                            Mail newMail = new Mail(to: owner.Email, bcc: "", cc: "", subject: subject, body: bodyMail, form: "Evento");
                            AddToQueue(newMail);
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

        private void SendToCoworkers(Event anEvent, string subject, string mailBody, List<UserData> listAllUsers)
        {
                foreach (var anUser in listAllUsers)
                {
                    Mail newMail = new Mail(to: anUser.Email, bcc: "", cc: "", subject: subject, body: mailBody, form: "Evento");

                    AddToQueue(newMail);
                }
        }

        private void AddToQueue(Mail email)
        {
            var helper = new MailHelper();
            int queueId = helper.AddToQueue(email);
            helper.WriteLog(email, queueId);
        }
    }
}