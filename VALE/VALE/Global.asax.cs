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
            // Initialize the product database.
            RoleActions.File = "Ruoli";
            Database.SetInitializer(new DatabaseInitializer());
            RoleActions.LoadRoles();
            using (var actions = new UserActions())
            {
                actions.CreateAdministrator();
            }

        
        }

        
    }
}