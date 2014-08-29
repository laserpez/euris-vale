using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Logic
{
    public class LogFactoryEmail
    {
        public static ILoggerEmail GetCurrentLoggerEmail()
        {
            string logType = System.Configuration.ConfigurationManager.AppSettings["LogType"];
            switch (logType)
            {
                case "db":
                    return new DBLoggerEmail();
                default:
                    return new DBLoggerEmail();
            }
        }
    }
}