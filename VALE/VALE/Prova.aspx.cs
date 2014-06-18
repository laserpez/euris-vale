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
            if (!IsPostBack)
            {
                ddlSelectProject.Visible = false;
                Session["filter"] = "All";
                filterPanel.Visible = false;
            }
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

        private List<Activity> ApplyFilters(List<Activity> activities)
        {
            string filterType = Session["filter"].ToString();
            if(filterType != null)
            {
                switch (filterType)
                {
                    case "All":
                    default:
                        break;
                    case "Project":
                        var projectId = Convert.ToInt32(ddlSelectProject.SelectedValue);
                        activities = activities.Where(a => a.RelatedProject != null && a.RelatedProject.ProjectId == projectId).ToList();
                        break;
                    case "Unrelated":
                        activities = activities.Where(a => a.RelatedProject == null).ToList();
                        break;
                }
            }
            if (!String.IsNullOrEmpty(txtDescription.Text))
                activities = activities.Where(a => a.Description.ToUpper().Contains(txtDescription.Text.ToUpper())).ToList();
            if (!String.IsNullOrEmpty(txtName.Text))
                activities = activities.Where(a => a.ActivityName.ToUpper().Contains(txtName.Text.ToUpper())).ToList();
            if (!String.IsNullOrEmpty(txtFromDate.Text))
            {
                var dateFrom = Convert.ToDateTime(txtFromDate.Text);
                activities = activities.Where(a => a.CreationDate >= dateFrom).ToList();
            }
            if (!String.IsNullOrEmpty(txtToDate.Text))
            {
                var dateTo = Convert.ToDateTime(txtToDate.Text);
                activities = activities.Where(a => a.CreationDate <= dateTo).ToList();
            }
            return activities;

        }

        public List<Activity> ToBePlannedGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return ApplyFilters(activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.ToBePlanned));
            }
        }

        public List<Activity> OngoingGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return ApplyFilters(activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.Ongoing));
            }
        }

        public List<Activity> DoneGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return ApplyFilters(activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.Done));
            }
        }

        public List<Activity> SuspendedGridViewGetData()
        {
            using (ActivityActions activityActions = new ActivityActions())
            {
                return ApplyFilters(activityActions.GetActivities(HttpContext.Current.User.Identity.Name, ActivityStatus.Suspended));
            }
        }

        protected void LinkButtonAllActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = true;
            ButtonProjectActivities.Visible = false;
            ButtonNotRelatedActivities.Visible = false;
            ddlSelectProject.Visible = false;
            Session["filter"] = "All";
            BindAllGrids();
        }

        protected void LinkButtonProjectActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = false;
            ButtonProjectActivities.Visible = true;
            ButtonNotRelatedActivities.Visible = false;
            ddlSelectProject.Visible = true;
            Session["filter"] = "Project";
        }

        protected void LinkButtonNotRelatedActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = false;
            ButtonProjectActivities.Visible = false;
            ButtonNotRelatedActivities.Visible = true;
            ddlSelectProject.Visible = false;
            Session["filter"] = "Unrelated";
            BindAllGrids();
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            BindAllGrids();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtDescription.Text = null;
            txtFromDate.Text = null;
            txtName.Text = null;
            txtToDate.Text = null;
            BindAllGrids();
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            BindAllGrids();
            filterPanel.Visible = !filterPanel.Visible;
        }

        private void BindAllGrids()
        {
            ToBePlannedGridView0.DataBind();
            OngoingGridView1.DataBind();
            SuspendedGridView2.DataBind();
            DoneGridView3.DataBind();
        }

        public List<Project> GetProjects()
        {
            var db = new UserOperationsContext();
            var userName = User.Identity.Name;
            var projects = db.UsersData.First(u => u.UserName == userName).AttendingProjects;
            projects.Insert(0, new Project { ProjectName = "-- Seleziona progetto --", ProjectId = 0});
            return projects;
        }

        protected void ddlSelectProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindAllGrids();
        }
    }
}