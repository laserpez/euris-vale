using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    [Serializable]
    public class BODReportActions : IFileActions
    {
        public ILogger logger { get; set; }

        public BODReportActions()
        {
            logger = LogFactory.GetCurrentLogger();
        }

        public bool AddAttachment(int dataId, Models.AttachedFile file)
        {
            try
            {
                var db = new UserOperationsContext();
                var report = db.BODReports.First(r => r.BODReportId == dataId);
                report.AttachedFiles.Add(file);
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
                var _db = new UserOperationsContext();
                var anAttachment = _db.AttachedFiles.FirstOrDefault(at => at.AttachedFileID == attachmentId);
                var BODReportId = anAttachment.RelatedBODReport.BODReportId;
                var aBODReport = _db.BODReports.Where(b => b.BODReportId == BODReportId).FirstOrDefault();
                aBODReport.AttachedFiles.Remove(anAttachment);
                _db.AttachedFiles.Remove(anAttachment);
                _db.SaveChanges();
                logger.Write(new LogEntry() { DataId = BODReportId, Username = HttpContext.Current.User.Identity.Name, DataAction = "E' stato rimosso il documento \"" + anAttachment.RelatedEvent.Name + "\"", DataType = "Verbale", Date = DateTime.Now, Description = "E' stato rimosso il documento \"" + anAttachment.FileName + "\"" });
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
            var report = db.BODReports.First(r => r.BODReportId == dataId);
            return report.AttachedFiles;
        }


        public bool RemoveAllAttachments(int dataId)
        {
            try
            {
                var db = new UserOperationsContext();
                var BODReport = db.BODReports.First(b => b.BODReportId == dataId);
                db.AttachedFiles.RemoveRange(BODReport.AttachedFiles);
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool SaveData<T>(T data, UserOperationsContext db)
        {
            try
            {
                var newBODReport = data as BODReport;

                db.BODReports.Add(newBODReport);
                db.SaveChanges();
                logger.Write(new LogEntry() { DataId = newBODReport.BODReportId, Username = HttpContext.Current.User.Identity.Name, DataAction = "Creato nuovo verbale del consiglio", DataType = "Verbale", Date = DateTime.Now, Description = "E' stato creato il nuovo evento \"" + newBODReport.Name + "\"" });
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}