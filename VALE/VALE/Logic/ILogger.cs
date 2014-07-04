using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VALE.Logic
{
    interface ILogger
    {
        List<LogEntry> Read(string filter, int count);
        bool Write(LogEntry log);
    }
}
