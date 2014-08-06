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
    public partial class Projects : Page
    {
        private string _currentUserName;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUserName = User.Identity.GetUserName();
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

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneProgetti"))
                btnAddProject.Visible = false;

            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Progetti"))
            {
                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina Projects.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public List<string> PopulateDropDown()
        {
            return new List<string>() { "Tutti", "Aperto", "Sospeso", "Chiuso" };
        }

        public List<Project> GetProjects()
        {
            var dbData = new UserOperationsContext();
            var projects =  dbData.Projects.Where(p => p.Public == true || p.OrganizerUserName == _currentUserName || p.InvolvedUsers.Select(u => u.UserName).Contains(_currentUserName)).ToList();
            return projects;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            string projectId = ((Button)sender).CommandArgument;
            Response.Redirect("/MyVale/ProjectDetails?projectId=" + projectId);
        }

        protected void OpenedProjectList_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;
            
            var actions = new ProjectActions();
            
            OpenedProjectList.DataSource = actions.GetSortedData(e.SortExpression, GridViewSortDirection, (List<Project>)ViewState["lstProject"]);
            
            OpenedProjectList.DataBind();
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
            var actions = new ProjectActions();
            
            var result = actions.GetFilteredData(filters, (List<Project>)ViewState["lstProject"]);
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
            btnFilterProjects.Visible = !btnFilterProjects.Visible;
            btnClearFilters.Visible = !btnClearFilters.Visible;            
        }

        protected void btnWorkOnThis_Click(object sender, EventArgs e)
        {
            int projectId = Convert.ToInt32(((Button)sender).CommandArgument);
            var actions = new ProjectActions();
            actions.AddOrRemoveUserData(projectId, _currentUserName);
            OpenedProjectList.DataSource = (List<Project>)ViewState["lstProject"];
            OpenedProjectList.DataBind();
        }

        protected void OpenedProjectList_DataBound(object sender, EventArgs e)
        {
            var actions = new ProjectActions();
            for (int i = 0; i < OpenedProjectList.Rows.Count; i++)
            {
                int projectId = (int)OpenedProjectList.DataKeys[i].Value;
                var db = new UserOperationsContext();

                Button btnAttend = (Button)OpenedProjectList.Rows[i].FindControl("btnWorkOnThis");

                if (db.Projects.Where(p => p.ProjectId == projectId).Select(pr => pr.Status).FirstOrDefault() == "Chiuso")
                    btnAttend.Enabled = false;

                if (actions.IsUserRelated(projectId, _currentUserName))
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

        public string GetDescription(string description)
        {
            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            doc.LoadHtml(description);
            description = doc.DocumentNode.InnerText;
            return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
        }

        protected void OpenedProjectList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            OpenedProjectList.PageIndex = e.NewPageIndex;
            OpenedProjectList.DataSource = GetProjects();
            OpenedProjectList.DataBind();
        }
         protected void btnAddProject_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ProjectCreate?From=~/MyVale/Projects");
        }

    }
}