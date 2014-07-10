using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    [Serializable]
    public class InterventionActions : IFileActions
    {
        public ILogger logger { get; set; }

        public InterventionActions()
        {
            logger = LogFactory.GetCurrentLogger();
        }

        public bool SaveData<T>(T data, UserOperationsContext db)
        {
            try
            {
                var newIntervention = data as Intervention;

                db.Interventions.Add(newIntervention);
                db.SaveChanges();

                var RelatedProjectName = db.Projects.Where(pr => pr.ProjectId == newIntervention.ProjectId).Select(pro => pro.ProjectName).FirstOrDefault();
                var textToView = newIntervention.InterventionText.Length >= 30 ? newIntervention.InterventionText.Substring(0, 30) + "..." : newIntervention.InterventionText;
                logger.Write(new LogEntry() { DataId = newIntervention.InterventionId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Aggiunta nuova conversazione in " + RelatedProjectName, DataType = "Conversazione", Date = DateTime.Now, Description = newIntervention.CreatorUserName + " ha aggiunto una conversazione: \"" + textToView + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool AddAttachment(int dataId, Models.AttachedFile file)
        {
            try
            {
                var db = new UserOperationsContext();
                var intervention = db.Interventions.First(i => i.InterventionId == dataId);
                intervention.AttachedFiles.Add(file);
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool RemoveAttachment(int attachmentId)
        {
            try
            {
                var db = new UserOperationsContext();
                var anAttachment = db.AttachedFiles.FirstOrDefault(at => at.AttachedFileID == attachmentId);
                db.AttachedFiles.Remove(anAttachment);

                db.SaveChanges();
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
            var intervention = db.Interventions.First(i => i.InterventionId == dataId);
            return intervention.AttachedFiles;
        }


        public bool RemoveAllAttachments(int dataId)
        {
            try
            {
                var db = new UserOperationsContext();
                var intervention = db.Interventions.First(i => i.InterventionId == dataId);
                db.AttachedFiles.RemoveRange(intervention.AttachedFiles);
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}