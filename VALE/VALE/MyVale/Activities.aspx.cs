using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using CsvHelper;
using System.IO;
using System.Text;
using VALE.Logic;
using System.Web.ModelBinding ;

namespace VALE.MyVale
{
    public partial class Activities : System.Web.UI.Page
    {
        private string _currentUserName;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserName = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                filterPanel.Visible = false;
            }
        }

        public string GetStatus(Activity anActivity)
        {
            string status;
            var activityActions = new ActivityActions();
                status = activityActions.GetStatus(anActivity);
            return status;
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ShowHideControls();
        }

        private void ShowHideControls()
        {
            if (grdCurrentActivities.Rows.Count == 0 && grdPendingActivities.Rows.Count == 0)
            {
                //filterPanel.Visible = false;
                //ExternalPanelDefault.Visible = false;
                //InternalPanelHeading.Visible = false;
                //btnExportCSV.Visible = false;
            }
        }

        public IQueryable<Activity> GetCurrentActivities([Control]string txtName, [Control]string txtDescription, [Control]string ddlStatus)
        {
            IQueryable<Activity> activities;
            var activityActions = new ActivityActions();
                activities = activityActions.GetCurrentActivities(txtName,txtDescription,ddlStatus,_currentUserName);
            return activities;
        }

        public IQueryable<Activity> GetPendingActivities()
        {
            IQueryable<Activity> activities;
            var activityActions = new ActivityActions();
                activities = activityActions.GetPendingActivities(_currentUserName);
            return activities;
            //var db = new UserOperationsContext();
            //var activities = db.UsersData.First(u => u.UserName == _currentUserName).PendingActivity.AsQueryable();
            //return activities;
        }

        protected void btnCreateActivity_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/ActivityCreate");
        }

        protected void grdCurrentActivities_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int activityId = (int)grdCurrentActivities.DataKeys[index].Value;
                Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
            }
        }

        protected void grdPendingActivities_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int activityId = Convert.ToInt32(grdPendingActivities.DataKeys[index].Value);
            var activityActions = new ActivityActions();
            var accept = false;
            if (e.CommandName == "AcceptActivity")
                accept = true;

            activityActions.AddOrRefusePendingActivity(activityId, accept);

            grdCurrentActivities.DataBind();
            grdPendingActivities.DataBind();
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            ExportToCSV(new List<string>() { _currentUserName });
        }

        public void ExportToCSV(List<string> usersNames)
        {
            using (var exportToCSV = new ExportToCSV())
            {
                string name = usersNames.Count == 1 ? usersNames[0] : "Gruppo Utenti";
                Response.AddHeader("content-disposition", string.Format("attachment; filename=ListActivities({0}).csv", name));
                Response.ContentType = "application/text";
                StringBuilder strbldr = exportToCSV.ExportActivities(usersNames);
                Response.Write(strbldr.ToString());
                Response.End();
            }
        }

        public string GetType(string typeId) 
        {
            var Id = Convert.ToInt32(typeId);
            var db = new UserOperationsContext();
            var type = db.ActivityTypes.FirstOrDefault(t => t.ActivityTypeId == Id);
            if (type != null)
                return type.ActivityTypeName;
            return "Generico";
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            grdCurrentActivities.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtDescription.Text = "";
            txtName.Text = "";
            ddlStatus.SelectedValue = "Tutte";
            grdCurrentActivities.DataBind();
        }

        public List<string> PopulateDropDown()
        {
            return new List<string>() { "Tutte", "Da pianificare", "In corso", "Sospese", "Terminate" };
        }
    }
}
