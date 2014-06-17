using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE
{
    public partial class Prova : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Method"] == "GetServerDate")
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                GetServerDate(Request.QueryString["format"]);
            }
        }

        private void GetServerDate(string dateformat)
        {
            Response.Clear();
            if (dateformat.Equals("utc"))
            {
                Response.Write(DateTime.Now.ToUniversalTime().ToString());
            }
            else
            {
                Response.Write(DateTime.Now.ToLocalTime().ToString());
            }
            Response.End();
        }


        public List<Activity> ToBePlannedGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.ToBePlanned);
            }
        }

        public List<Activity> OngoingGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.Ongoing);
            }
        }

        public List<Activity> DoneGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.Done);
            }
        }

        public List<Activity> SuspendedGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.Suspended);
            }
        }
    }
}