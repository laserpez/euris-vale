using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using VALE.Models;

namespace VALE.Logic
{
    [Serializable]
    class DBLogger: ILogger
    {
        public List<LogEntry> Read(string filter, int count)
        {
            return new List<LogEntry>();
        }

        public bool Write(LogEntry log)
        {
            try
            {
                var db = new UserOperationsContext();

                if (db.LogEntries.Count() > 100)
                {
                    var sortedList = db.LogEntries.OrderBy(l => l.Date);
                    var lastLogEntry = sortedList.ElementAt(0);
                    db.LogEntries.Remove(lastLogEntry);
                }

                db.LogEntries.Add(log);
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
