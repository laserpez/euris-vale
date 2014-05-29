using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using VALE.Models;

namespace VALE
{
    /// <summary>
    /// Summary description for AutoComplete
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AutoComplete : System.Web.Services.WebService
    {

        public AutoComplete()
        {

            //Uncomment the following line if using designed components
            //InitializeComponent();
        }

        [WebMethod]
        public string[] GetProjectNames(string prefixText, int count)
        {
            var db = new UserOperationsContext();
            string[] projects = db.Projects.Select(p => p.ProjectName).ToArray();
            return (from p in projects where p.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase) select p).Take(count).ToArray();
        }

        [WebMethod]
        public string[] GetUserNames(string prefixText, int count)
        {
            var db = new ApplicationDbContext();
            string[] users = db.Users.Select(u => u.FirstName + " " + u.LastName).ToArray();
            return (from u in users where u.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase) select u).Take(count).ToArray();
        }

    }
}
