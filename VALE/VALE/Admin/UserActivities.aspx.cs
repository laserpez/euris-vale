using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.Admin
{
    public partial class UserActivities : Page
    {
        private int _activityId;
        private string _userEmail;

        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            if (Request.QueryString.HasKeys())
            {
                _activityId = Convert.ToInt32(Request.QueryString.GetValues("activityId").First());
                _userEmail = Request.QueryString.GetValues("userId").First();
            }
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "Amministrazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina UserActivities.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public IQueryable<ActivityReport> GetUserActivities([QueryString("activityId")] int? activityId, [QueryString("userId")] string userEmail)
        {
            var db = new UserOperationsContext();
            if (activityId.HasValue && !String.IsNullOrEmpty(userEmail))
            {
                return db.Reports.Where(r => r.Worker.Email == userEmail && r.ActivityId == activityId);
            }
            else
                return null;
        }

        public string GetWorkerName()
        {
            var db = new UserOperationsContext();
            return db.UserDatas.First(u => u.Email == _userEmail).FullName;
        }

        public string GetWorkedActivity()
        {
            var db = new UserOperationsContext();
            return db.Activities.First(a => a.ActivityId == _activityId).ActivityName;
        }

        protected void grdReports_DataBound(object sender, EventArgs e)
        {
            HeaderName.Text = String.Format("Report per l'utente {0} sull'attività {1}", GetWorkerName(), GetWorkedActivity());
        }


    }
}