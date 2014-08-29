using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    [Serializable]
    public class DBLoggerEmail : ILoggerEmail
    {
        private int MaxIntervalDays = Convert.ToInt32(ConfigurationManager.AppSettings["MaxIntervalDays"].ToString());
        public List<LogEntryEmail> Read(string filter, int count)
        {
            return new List<LogEntryEmail>();
        }

        public bool Write(LogEntryEmail log)
        {
            try
            {
                var db = new UserOperationsContext();

                var sortedList = db.LogEntriesEmail.OrderBy(l => l.Date);
                foreach (var sortedLog in sortedList)
                {
                    DateTime oldDate = sortedLog.Date;
                    DateTime newDate = DateTime.Now;

                    TimeSpan ts = newDate - oldDate;
                    int differenceInDays = ts.Days;
                    if (differenceInDays >= MaxIntervalDays)
                        db.LogEntriesEmail.Remove(sortedLog);
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