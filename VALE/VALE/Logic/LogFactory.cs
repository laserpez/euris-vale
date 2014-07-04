using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Logic
{
    public class LogFactory
    {
        public static ILogger GetCurrentLogger()
        {
            string logType = System.Configuration.ConfigurationManager.AppSettings["LogType"];
            switch (logType)
            {
                case "db":
                    return new DBLogger();
                default:
                    return new DBLogger();
            }
        }
    }
}