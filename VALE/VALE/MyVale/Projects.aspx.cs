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
            return dbData.Projects.ToList();
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            string id = OpenedProjectList.DataKeys[rowID].Value.ToString();
            Response.Redirect("/MyVale/ProjectDetails?projectId=" + id);
        }

        protected void OpenedProjectList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;

            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;
            
            OpenedProjectList.DataSource = GetSortedData(e.SortExpression);
            OpenedProjectList.DataBind();
        }

        private List<Project> GetSortedData(string sortExpression)
        {
            var result = (List<Project>)ViewState["lstProject"];

            var param = Expression.Parameter(typeof(Project), sortExpression);
            var sortBy = Expression.Lambda<Func<Project, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                result = result.AsQueryable<Project>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Project>().OrderBy(sortBy).ToList();
            ViewState["lstProject"] = result;
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

        //protected void btnViewClosedDetails_Click(object sender, EventArgs e)
        //{
        //    int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
        //    string id = grdClosedProject.Rows[rowID].Cells[0].Text;
        //    Response.Redirect("/MyVale/ProjectDetails?projectId=" + id);
        //}

        protected void btnFilterProjects_Click(object sender, EventArgs e)
        {
            ViewState["lstProject"] = GetProjects();
            if (!String.IsNullOrEmpty(txtName.Text))
                FilterByName(txtName.Text);
            if (!String.IsNullOrEmpty(txtDescription.Text))
                FilterByDescription(txtDescription.Text);
            if (!String.IsNullOrEmpty(txtCreationDate.Text))
                FilterByCreationDate(txtCreationDate.Text);
            if (!String.IsNullOrEmpty(txtLastModifiedDate.Text))
                FilterByLastModifiedDate(txtLastModifiedDate.Text);
            if (ddlStatus.SelectedValue != "Tutti")
                FilterByProjectStatus(ddlStatus.SelectedValue);
            var result = (List<Project>)ViewState["lstProject"];
            OpenedProjectList.DataSource = result;
            OpenedProjectList.DataBind();
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

        private void FilterByName(string name)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.ProjectName.ToLower().Contains(name.ToLower())).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByDescription(string description)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.Description.ToLower().Contains(description.ToLower())).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByCreationDate(string creationDate)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.CreationDate.ToShortDateString() == creationDate).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByLastModifiedDate(string lastModified)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.LastModified.ToShortDateString() == lastModified).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByProjectStatus(string status)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.Status.ToUpper() == status.ToUpper()).ToList();
            ViewState["lstProject"] = result;
        }

        protected void btnWorkOnThis_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            int projectId = Convert.ToInt32(OpenedProjectList.Rows[rowID].Cells[0].Text);
            var db = new UserOperationsContext();
            UserData user = db.UsersData.First(u => u.UserName == _currentUser);
            Project thisProject = db.Projects.First(ev => ev.ProjectId == projectId);
            Button btnAttend = (Button)sender;
            if (btnAttend.CssClass == "btn btn-info btn-xs")
            {
                thisProject.InvolvedUsers.Add(user);
                user.AttendingProjects.Add(thisProject);
                db.SaveChanges();
            }
            else
            {
                thisProject.InvolvedUsers.Remove(user);
                user.AttendingProjects.Remove(thisProject);
                db.SaveChanges();
            }
            ViewState["lstProject"] = GetProjects();
            OpenedProjectList.DataSource = (List<Project>)ViewState["lstProject"];
            OpenedProjectList.DataBind();
        }

        protected void OpenedProjectList_DataBound(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            for (int i = 0; i < OpenedProjectList.Rows.Count; i++)
            {
                Button btnAttend = (Button)OpenedProjectList.Rows[i].FindControl("btnWorkOnThis");
                int projectId = (int)OpenedProjectList.DataKeys[i].Value;
                if (dbData.UsersData.First(u => u.UserName == _currentUser).AttendingProjects.Contains(dbData.Projects.First(p => p.ProjectId == projectId)))
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