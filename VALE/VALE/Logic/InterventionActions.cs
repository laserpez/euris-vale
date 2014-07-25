﻿using System;
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
                if (newIntervention.RelatedProject != null)
                {
                    newIntervention.RelatedProject.LastModified = DateTime.Now;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(newIntervention.RelatedProject.ProjectId);
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
                db.SaveChanges();

                var RelatedProjectName = db.Projects.Where(pr => pr.ProjectId == newIntervention.ProjectId).Select(pro => pro.ProjectName).FirstOrDefault();
                var textToView = newIntervention.InterventionText.Length >= 30 ? newIntervention.InterventionText.Substring(0, 30) + "..." : newIntervention.InterventionText;
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(textToView);
                var clearedText = doc.DocumentNode.InnerText;
                logger.Write(new LogEntry() { DataId = newIntervention.InterventionId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Aggiunta nuova conversazione in " + RelatedProjectName, DataType = "Conversazione", Date = DateTime.Now, Description = newIntervention.CreatorUserName + " ha aggiunto una conversazione: \"" + clearedText + "\"" });
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
                if (intervention.RelatedProject != null)
                {
                    intervention.RelatedProject.LastModified = DateTime.Now;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(intervention.RelatedProject.ProjectId);
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
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

                var interventionId = anAttachment.RelatedIntervention.InterventionId;
                var anIntervention = db.Interventions.Where(i => i.InterventionId == interventionId).FirstOrDefault();
                anIntervention.AttachedFiles.Remove(anAttachment);
                if (anIntervention.RelatedProject != null)
                {
                    anIntervention.RelatedProject.LastModified = DateTime.Now;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(anIntervention.RelatedProject.ProjectId);
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
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
                var anIntervention = db.Interventions.First(i => i.InterventionId == dataId);
                db.AttachedFiles.RemoveRange(anIntervention.AttachedFiles);
                if (anIntervention.RelatedProject != null)
                {
                    anIntervention.RelatedProject.LastModified = DateTime.Now;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(anIntervention.RelatedProject.ProjectId);
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }
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