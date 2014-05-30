using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Timers;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using VALE.Logic;
using VALE.Models;

namespace VALE
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            RoleActions.CreateRoles();
            UserActions.CreateAdministrator();

            // Create a timer.
            var aTimer = new Timer();
            aTimer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            aTimer.Interval = 21600000; // 6 hour
            aTimer.Enabled = true;
        }

        private static void OnTimedEvent(object source, ElapsedEventArgs e)
        {
            var db = new UserOperationsContext();
            db.UsersData.Add(new UserData { UserName = DateTime.Now.ToString() });
            //db.Activities.Where(o => o.ExpireDate.CompareTo(DateTime.Now) )
            db.SaveChanges();
        }
    }
}