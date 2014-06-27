using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class ReportActions : IActions
    {
        public List<T> GetSortedData<T>(string sortExpression, System.Web.UI.WebControls.SortDirection direction, List<T> data)
        {
            throw new NotImplementedException();
        }

        public List<T> GetFilteredData<T>(Dictionary<string, string> filters, List<T> data)
        {
            throw new NotImplementedException();
        }

        public bool AddOrRemoveUserData<T>(T data, Models.UserData user)
        {
            throw new NotImplementedException();
        }

        public bool IsUserRelated(int dataId, string username)
        {
            throw new NotImplementedException();
        }

        public bool AddAttachment(int dataId, Models.AttachedFile file)
        {
            try
            {
                var db = new UserOperationsContext();
                var project = db.Projects.First(p => p.ProjectId == dataId);
                project.AttachedFiles.Add(file);
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

        public List<Models.AttachedFile> GetAttachments(int dataId)
        {
            var db = new UserOperationsContext();
            var report = db.BODReports.First(r => r.BODReportId == dataId);
            return report.AttachedFiles;
        }
    }
}