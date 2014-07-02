﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class BODReportActions : IActions
    {
        public List<T> GetSortedData<T>(string sortExpression, System.Web.UI.WebControls.SortDirection direction, List<T> data)
        {
            return null;
        }

        public List<T> GetFilteredData<T>(Dictionary<string, string> filters, List<T> data)
        {
            return null;
        }

        public bool IsUserRelated(int dataId, string username)
        {
            return false;
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


        public IQueryable<UserData> GetRelatedUsers(int dataId)
        {
            return null;
        }


        public bool AddOrRemoveUserData(int dataId, UserData user)
        {
            return false;
        }


        public bool AddOrRemoveUserData<T>(T data, UserData user)
        {
            throw new NotImplementedException();
        }

        public bool AddOrRemoveUserData(int dataId, string username)
        {
            throw new NotImplementedException();
        }


        public List<UserData> GetRelatedUsers(string _dataId)
        {
            return null;
        }


        public bool IsGroupRelated(int dataId, int groupId)
        {
            throw new NotImplementedException();
        }

        public IQueryable<Group> GetRelatedGroups(int _dataId)
        {
            throw new NotImplementedException();
        }
    }
}