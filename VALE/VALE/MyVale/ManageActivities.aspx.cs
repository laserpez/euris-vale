using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
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
            HideIdColumns();
            PopulateFilters();
            if (Request.QueryString["Method"] == "ChangeStatus")
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                int id = Convert.ToInt16(Request.QueryString["id"]);
                string statusNumber = Request.QueryString["status"];
                ChangeStatus(id, statusNumber);
            }
        }

        private void HideIdColumns()
        {
            string hideId = @"$(function () {
            var gridrows = document.getElementById('MainContent_ToBePlannedGridView0').rows;
            for (var i = 0; i < gridrows.length; i++) {
                gridrows[i].cells[0].style.display = 'none';
            }
            var gridrows = document.getElementById('MainContent_OngoingGridView1').rows;
            for (var i = 0; i < gridrows.length; i++) {
                gridrows[i].cells[0].style.display = 'none';
            }
            var gridrows = document.getElementById('MainContent_SuspendedGridView2').rows;
            for (var i = 0; i < gridrows.length; i++) {
                gridrows[i].cells[0].style.display = 'none';
            }
            var gridrows = document.getElementById('MainContent_DoneGridView3').rows;
            for (var i = 0; i < gridrows.length; i++) {
                gridrows[i].cells[0].style.display = 'none';
            }
            });";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "hideId", hideId, true);
        }

        private void ApplyDragAndDrop()
        {
            string dragAndDrop = @"$(function () {
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
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "dragAndDrop", dragAndDrop, true);
        }

        private void PopulateFilters()
        {
            if (Session["ManageActivities_txtDescription"] != null)
                txtDescription.Text = Session["ManageActivities_txtDescription"].ToString();
            if (Session["ManageActivities_txtName"] != null)
                txtName.Text = Session["ManageActivities_txtName"].ToString();
            if (Session["ManageActivities_txtFromDate"] != null)
                txtFromDate.Text = Session["ManageActivities_txtFromDate"].ToString();
            if (Session["ManageActivities_txtToDate"] != null)
                txtToDate.Text = Session["ManageActivities_txtToDate"].ToString();
            if (Session["ManageActivities_projectId"] != null)
                ddlSelectProject.SelectedValue = Session["ManageActivities_projectId"].ToString();
            string filterType= "All";
            if(Session["ManageActivities_filterType"] != null)
                filterType = Session["ManageActivities_filterType"].ToString();
            if (filterType != null)
            {
                switch (filterType)
                {
                    case "All":
                    default:
                        SetAllActivities();
                        break;
                    case "Project":
                        LinkButtonProjectActivities_Click(new object(), new EventArgs());
                        break;
                    case "Unrelated":
                        SetNotRelatedActivities();
                        break;
                }
            }
            if (Session["ManageActivities_filterIsVisible"] != null)
                showFilters();
            else
                hideFilters();
        }

        private void ChangeStatus(int id, string statusNumber)
        {
            Response.Clear();
            ActivityStatus status = (ActivityStatus)Convert.ToInt16(statusNumber);
            using (var activityActions = new ActivityActions())
            {
                activityActions.SetActivityStatus(id, status);
            }
            //BindAllGrids();
            Response.Write("True");
            Response.End();
            
        }

        private List<Activity> ApplyFilters(List<Activity> activities)
        {
            string filterType = Session["ManageActivities_filterType"].ToString();
            if (filterType != null)
            {
                switch (filterType)
                {
                    case "All":
                    default:
                        break;
                    case "Project":
                        var projectId = 0;
                        int.TryParse(ddlSelectProject.SelectedValue, out projectId);
                        activities = activities.Where(a => a.RelatedProject != null && a.RelatedProject.ProjectId == projectId).ToList();
                        break;
                    case "Unrelated":
                        activities = activities.Where(a => a.RelatedProject == null).ToList();
                        break;
                }
            }
            if (Session["ManageActivities_txtDescription"] != null)
                activities = activities.Where(a => a.Description.ToUpper().Contains(Session["ManageActivities_txtDescription"].ToString().ToUpper())).ToList();
            if (Session["ManageActivities_txtName"] != null)
                activities = activities.Where(a => a.ActivityName.ToUpper().Contains(Session["ManageActivities_txtName"].ToString().ToUpper())).ToList();
            if (Session["ManageActivities_txtFromDate"] != null)
            {
                var dateFrom = Convert.ToDateTime(Session["ManageActivities_txtFromDate"].ToString());
                activities = activities.Where(a => a.CreationDate >= dateFrom).ToList();
            }
            if (Session["ManageActivities_txtToDate"] != null)
            {
                var dateTo = Convert.ToDateTime(Session["ManageActivities_txtToDate"].ToString());
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
            SetAllActivities();
            hideFilters();
        }

        private void SetAllActivities()
        {
            ButtonAllActivities.Visible = true;
            ButtonProjectActivities.Visible = false;
            ButtonNotRelatedActivities.Visible = false;
            Session["ManageActivities_filterType"] = "All";
            hideDropDownProject();
            BindAllGrids();
        }

        protected void LinkButtonProjectActivities_Click(object sender, EventArgs e)
        {
            ButtonAllActivities.Visible = false;
            ButtonProjectActivities.Visible = true;
            ButtonNotRelatedActivities.Visible = false;
            Session["ManageActivities_filterType"] = "Project";
            showDropDownProject();
        }

        protected void LinkButtonNotRelatedActivities_Click(object sender, EventArgs e)
        {
            SetNotRelatedActivities();
            hideFilters();
        }

        private void SetNotRelatedActivities() 
        {
            ButtonAllActivities.Visible = false;
            ButtonProjectActivities.Visible = false;
            ButtonNotRelatedActivities.Visible = true;
            Session["ManageActivities_filterType"] = "Unrelated";
            hideDropDownProject();
            BindAllGrids();
        }

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtDescription.Text))
                Session["ManageActivities_txtDescription"] = txtDescription.Text;
            if (!String.IsNullOrEmpty(txtName.Text))
                Session["ManageActivities_txtName"] = txtName.Text;
            if (!String.IsNullOrEmpty(txtFromDate.Text))
                Session["ManageActivities_txtFromDate"] = txtFromDate.Text;
            if (!String.IsNullOrEmpty(txtToDate.Text))
                Session["ManageActivities_txtToDate"] = txtToDate.Text;
            BindAllGrids();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            Session["ManageActivities_txtDescription"] = null;
            Session["ManageActivities_txtName"] = null;
            Session["ManageActivities_txtFromDate"] = null;
            Session["ManageActivities_txtToDate"] = null;
            txtDescription.Text = null;
            txtFromDate.Text = null;
            txtName.Text = null;
            txtToDate.Text = null;
            BindAllGrids();
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            if (filterPanel.Visible)
                hideFilters();
            else
                showFilters();
        }

        private void BindAllGrids()
        {
            ToBePlannedGridView0.DataSource = ToBePlannedGridViewGetData();
            ToBePlannedGridView0.DataBind();

            OngoingGridView1.DataSource = OngoingGridViewGetData();
            OngoingGridView1.DataBind();

            SuspendedGridView2.DataSource = SuspendedGridViewGetData();
            SuspendedGridView2.DataBind();

            DoneGridView3.DataSource = DoneGridViewGetData();
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
            Session["ManageActivities_projectId"] = ddlSelectProject.SelectedValue;
            BindAllGrids();
        }

        protected void btnCreateActivityToBePlannedStatus_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ActivityCreate?From=~/MyVale/ManageActivities&Status=ToBePlannedStatus");
        }

        protected void btnCreateActivityOngoingStatus_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ActivityCreate?From=~/MyVale/ManageActivities&Status=OngoingStatus");
        }

        protected void btnCreateActivitySuspendedStatus_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ActivityCreate?From=~/MyVale/ManageActivities&Status=SuspendedStatus");
        }

        protected void btnCreateActivityDoneStatus_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ActivityCreate?From=~/MyVale/ManageActivities&Status=DoneStatus");
        }

        private void showFilters() 
        {
            filterPanel.Visible = true;
            btnShowFilters.Text = "Nascondi filtri";
            Session["ManageActivities_filterIsVisible"] = "true";
        }

        private void hideFilters()
        {
            filterPanel.Visible = false;
            btnShowFilters.Text = "Visualizza filtri";
            Session["ManageActivities_filterIsVisible"] = null;
        }

        private void showDropDownProject() 
        {
            projectPanel.Visible = true;
            if (filterPanel.Visible == false)
                showFilters();

        }

        private void hideDropDownProject()
        {
            projectPanel.Visible = false;
        }

        protected void ToBePlannedGridViewLinkButton_Click(object sender, EventArgs e)
        {
            int RowId = ((GridViewRow)((LinkButton)sender).Parent.Parent).RowIndex;
            string activityId = ToBePlannedGridView0.Rows[RowId].Cells[0].Text;
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
        }

        protected void OngoingGridViewLinkButton_Click(object sender, EventArgs e)
        {
            int RowId = ((GridViewRow)((LinkButton)sender).Parent.Parent).RowIndex;
            string activityId = OngoingGridView1.Rows[RowId].Cells[0].Text;
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
        }

        protected void SuspendedGridViewLinkButton_Click(object sender, EventArgs e)
        {
            int RowId = ((GridViewRow)((LinkButton)sender).Parent.Parent).RowIndex;
            string activityId = SuspendedGridView2.Rows[RowId].Cells[0].Text;
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
        }

        protected void DoneGridViewLinkButton_Click(object sender, EventArgs e)
        {
            int RowId = ((GridViewRow)((LinkButton)sender).Parent.Parent).RowIndex;
            string activityId = DoneGridView3.Rows[RowId].Cells[0].Text;
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + activityId);
        }

        protected void ActivitiesSortedByName_Click(object sender, EventArgs e)
        {
            var currentGridView = (GridView)sender;
            var listAllActivities = GetActivitiesFromGridView(currentGridView);
            currentGridView.DataSource = (from ac in listAllActivities orderby ac.ActivityName descending select ac).ToList();
            currentGridView.DataBind();
            
        }

        private List<Activity> GetActivitiesFromGridView(GridView currentGridView)
        {
            List<Activity> activitiesList = new List<Activity>();
            var db = new UserOperationsContext();

            foreach (GridViewRow row in currentGridView.Rows)
	        {
                int activityId = Convert.ToInt32(row.Cells[0].Text);
                var anActivity = db.Activities.Where(ac => ac.ActivityId == activityId).FirstOrDefault();
                activitiesList.Add(anActivity);
	        }
            
            return activitiesList;
        }

        protected void GridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            var currentGridView = (GridView)sender;
            var listAllActivities = GetActivitiesFromGridView(currentGridView);
            currentGridView.DataSource = GetSortedData(e.SortExpression, listAllActivities);
            currentGridView.DataBind();
        }

        private List<Activity> GetSortedData(string sortExpression, List<Activity> listAllActivities)
        {
            var result = listAllActivities;
            var param = Expression.Parameter(typeof(Activity), sortExpression);
            var sortBy = Expression.Lambda<Func<Activity, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                result = result.AsQueryable<Activity>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Activity>().OrderBy(sortBy).ToList();
            return result;
        }

        public SortDirection GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] == null)
                    ViewState["sortDirection"] = SortDirection.Ascending;

                return (SortDirection)ViewState["sortDirection"];
            }
            set { ViewState["sortDirection"] = value; }
        }
    }
}