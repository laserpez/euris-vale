using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    [Serializable]
    public class DBLoggerEmail : ILoggerEmail
    {
        public List<LogEntryEmail> Read(string filter, int count)
        {
            return new List<LogEntryEmail>();
        }

        public bool Write(LogEntryEmail log)
        {
            try
            {
                var db = new UserOperationsContext();

                if (db.LogEntriesEmail.Count() > 1000)
                {
                    var sortedList = db.LogEntries.OrderBy(l => l.Date);
                    var lastLogEntry = sortedList.ElementAt(0);
                    db.LogEntries.Remove(lastLogEntry);
                }

                db.LogEntriesEmail.Add(log);
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public string GetStatus(LogEntryEmail logEntryEmail)
        {
            if (logEntryEmail.Status == EmailStatus.Sent)
                return "Inviata";
            if (logEntryEmail.Status == EmailStatus.Pending)
                return "In coda";
            if (logEntryEmail.Status == EmailStatus.Rejected)
                return "Rifiutata";

            return null;
        }
    }
}