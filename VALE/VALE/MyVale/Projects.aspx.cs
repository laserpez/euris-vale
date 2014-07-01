using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class Projects : System.Web.UI.Page
    {
        private string _currentUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if(!IsPostBack)
            {

                var lstProject = GetProjects();
                OpenedProjectList.DataSource = lstProject;
                OpenedProjectList.DataBind();
                ViewState["lstProject"] = lstProject;

                if (OpenedProjectList.Rows.Count == 0)
                {
                    ExternalPanelDefault.Visible = false;
                    InternalPanelHeading.Visible = false;
                    btnShowFilters.Visible = false;
                }
                
                filterPanel.Visible = false;
            }
        }

        public List<string> PopulateDropDown()
        {
            return new List<string>() { "Tutti", "Aperto", "Sospeso", "Chiuso" };
        }

        public List<Project> GetProjects()
        {
            var dbData = new UserOperationsContext();
            //var currentUserData = dbData.UsersData.FirstOrDefault(u => u.UserName == _currentUser);
            var projects =  dbData.Projects.Where(p => p.Public == true || p.OrganizerUserName == _currentUser || p.InvolvedUsers.Select(u => u.UserName).Contains(_currentUser)).ToList();
            return projects;
            
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            string projectId = ((Button)sender).CommandArgument;
            //int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            //string id = OpenedProjectList.DataKeys[rowID].Value.ToString();
            Response.Redirect("/MyVale/ProjectDetails?projectId=" + projectId);
        }

        protected void OpenedProjectList_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;
            
            //OpenedProjectList.DataSource = GetSortedData(e.SortExpression);
            using (var actions = new ProjectActions())
            {
                OpenedProjectList.DataSource = actions.GetSortedData(e.SortExpression, GridViewSortDirection, (List<Project>)ViewState["lstProject"]);
            }
            OpenedProjectList.DataBind();
        }

        //private List<Project> GetSortedData(string sortExpression)
        //{
        //    var result = (List<Project>)ViewState["lstProject"];

        //    var param = Expression.Parameter(typeof(Project), sortExpression);
        //    var sortBy = Expression.Lambda<Func<Project, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

        //    if (GridViewSortDirection == SortDirection.Descending)
        //        result = result.AsQueryable<Project>().OrderByDescending(sortBy).ToList();
        //    else
        //        result = result.AsQueryable<Project>().OrderBy(sortBy).ToList();
        //    ViewState["lstProject"] = result;
        //    return result;
        //}

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

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            var filters = new Dictionary<string, string>();
            ViewState["lstProject"] = GetProjects();
            if (!String.IsNullOrEmpty(txtName.Text))
                filters.Add("Name", txtName.Text);
            if (!String.IsNullOrEmpty(txtDescription.Text))
                filters.Add("Description", txtDescription.Text);
            if (!String.IsNullOrEmpty(txtCreationDate.Text))
                filters.Add("CreationDate", txtCreationDate.Text);
            if (!String.IsNullOrEmpty(txtLastModifiedDate.Text))
                filters.Add("LastModifiedDate", txtLastModifiedDate.Text);
            if (ddlStatus.SelectedValue != "Tutti")
                filters.Add("ProjectStatus", ddlStatus.SelectedValue);
            using (var actions = new ProjectActions())
            {
                var result = actions.GetFilteredData(filters, (List<Project>)ViewState["lstProject"]);
                OpenedProjectList.DataSource = result;
                OpenedProjectList.DataBind();
            }
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtDescription.Text = "";
            txtCreationDate.Text = "";
            txtLastModifiedDate.Text = "";
            ddlStatus.SelectedValue = "Tutti";
            var result = GetProjects();
            ViewState["lstProject"] = result;
            OpenedProjectList.DataSource = result;
            OpenedProjectList.DataBind();

        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        //private void FilterByName(string name)
        //{
        //    var result = (List<Project>)ViewState["lstProject"];
        //    result = result.Where(p => p.ProjectName.ToLower().Contains(name.ToLower())).ToList();
        //    ViewState["lstProject"] = result;
        //}

        //private void FilterByDescription(string description)
        //{
        //    var result = (List<Project>)ViewState["lstProject"];
        //    result = result.Where(p => p.Description.ToLower().Contains(description.ToLower())).ToList();
        //    ViewState["lstProject"] = result;
        //}

        //private void FilterByCreationDate(string creationDate)
        //{
        //    var result = (List<Project>)ViewState["lstProject"];
        //    result = result.Where(p => p.CreationDate.ToShortDateString() == creationDate).ToList();
        //    ViewState["lstProject"] = result;
        //}

        //private void FilterByLastModifiedDate(string lastModified)
        //{
        //    var result = (List<Project>)ViewState["lstProject"];
        //    result = result.Where(p => p.LastModified.ToShortDateString() == lastModified).ToList();
        //    ViewState["lstProject"] = result;
        //}

        //private void FilterByProjectStatus(string status)
        //{
        //    var result = (List<Project>)ViewState["lstProject"];
        //    result = result.Where(p => p.Status.ToUpper() == status.ToUpper()).ToList();
        //    ViewState["lstProject"] = result;
        //}

        protected void btnWorkOnThis_Click(object sender, EventArgs e)
        {
            int projectId = Convert.ToInt32(((Button)sender).CommandArgument);
            var db = new UserOperationsContext();
            var thisProject = db.Projects.First(p => p.ProjectId == projectId);
            var user = db.UsersData.First(u => u.UserName == User.Identity.Name);
            using(var actions = new ProjectActions())
            {
                actions.AddOrRemoveUserData(thisProject, user);
                db.SaveChanges();
                OpenedProjectList.DataSource = (List<Project>)ViewState["lstProject"];
                OpenedProjectList.DataBind();
            }
            //var db = new UserOperationsContext();
            //UserData user = db.UsersData.First(u => u.UserName == _currentUser);
            //Project thisProject = db.Projects.First(ev => ev.ProjectId == projectId);
            //Button btnAttend = (Button)sender;
            //if (btnAttend.CssClass == "btn btn-info btn-xs")
            //{
            //    thisProject.InvolvedUsers.Add(user);
            //    user.AttendingProjects.Add(thisProject);
            //    db.SaveChanges();
            //}
            //else
            //{
            //    thisProject.InvolvedUsers.Remove(user);
            //    user.AttendingProjects.Remove(thisProject);
            //    db.SaveChanges();
            //}
            
        }

        protected void OpenedProjectList_DataBound(object sender, EventArgs e)
        {
            using (var actions = new ProjectActions())
            {
                for (int i = 0; i < OpenedProjectList.Rows.Count; i++)
                {
                    Button btnAttend = (Button)OpenedProjectList.Rows[i].FindControl("btnWorkOnThis");
                    int projectId = (int)OpenedProjectList.DataKeys[i].Value;
                    if (actions.IsUserRelated(projectId, _currentUser))
                    {
                        btnAttend.CssClass = "btn btn-success btn-xs";
                        btnAttend.Text = "Stai partecipando";
                    }
                    else
                    {
                        btnAttend.CssClass = "btn btn-info btn-xs";
                        btnAttend.Text = "Partecipa";
                    }
                }
            }
        }
    }
}