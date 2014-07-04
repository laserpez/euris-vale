﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class BODReportActions : IFileActions
    {
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


        public bool RemoveAllAttachments(int dataId)
        {
            return false;
        }
    }
}