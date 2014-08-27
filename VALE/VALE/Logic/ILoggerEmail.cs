using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VALE.Logic
{
    public interface ILoggerEmail
    {
        List<LogEntryEmail> Read(string filter, int count);
        bool Write(LogEntryEmail log);
        string GetStatus(LogEntryEmail log);
    }
}
