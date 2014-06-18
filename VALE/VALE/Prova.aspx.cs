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
            if (Request.QueryString["Method"] == "ChangeStatus")
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                int id = Convert.ToInt16(Request.QueryString["id"]);
                string statusNumber = Request.QueryString["status"];
                ChangeStatus(id, statusNumber);
            }
        }

        private void ChangeStatus(int id, string statusNumber)
        {
            Response.Clear();
            ActivityStatus status = (ActivityStatus)Convert.ToInt16(statusNumber);
            using (var activityActions = new ActivityActions())
            {
                activityActions.SetActivityStatus(id, status);
            }
            Response.Write("True");
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

        protected void LinkButtonAllActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = true;
            ButtonProjectActivities.Visible = false;
            ButtonNotRelatedActivities.Visible = false;
        }

        protected void LinkButtonProjectActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = false;
            ButtonProjectActivities.Visible = true;
            ButtonNotRelatedActivities.Visible = false;
        }

        protected void LinkButtonNotRelatedActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = false;
            ButtonProjectActivities.Visible = false;
            ButtonNotRelatedActivities.Visible = true;
        }
    }
}