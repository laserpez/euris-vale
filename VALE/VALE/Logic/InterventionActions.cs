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