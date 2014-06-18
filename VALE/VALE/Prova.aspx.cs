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
            ApplyDragAndDrop();
            if (Request.QueryString["Method"] == "ChangeStatus")
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                int id = Convert.ToInt16(Request.QueryString["id"]);
                string statusNumber = Request.QueryString["status"];
                ChangeStatus(id, statusNumber);
            }
        }

        private void ApplyDragAndDrop() 
        {
            string _myScript = @"$(function () {
            $('.table').sortable({
                items: 'tr:not(tr:first-child)',
                cursor: 'crosshair',
                connectWith: '.table',
                dropOnEmpty: true,
                receive: function (e, ui) {
                    $(this).find('tbody').append(ui.item);
                    var receverTableId = this.id;
                    var status = receverTableId.charAt(receverTableId.length - 1);
                    var activityId = ui.item.find('td')[0].innerHTML;
                    ChangeStatus(activityId, status);
                    }
                });
            });";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "myScript", _myScript, true); 
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