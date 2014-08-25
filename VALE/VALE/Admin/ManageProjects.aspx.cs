using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System.Linq.Expressions;
using VALE.Logic;

namespace VALE.Admin
{
    public partial class ManageProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            if (!IsPostBack)
            {
                var lstProject = GetProjects();
                ProjectList.DataSource = lstProject;
                ProjectList.DataBind();
                ViewState["lstProject"] = lstProject;
                ShowHideControls();
                filterPanel.Visible = false;
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ManageProject.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        private void ShowHideControls()
        {
            var projects = (List<Project>)ViewState["lstProject"];
            if (projects.Count == 0)
            {
                filterPanel.Visible = false;
                btnShowFilters.Visible = false;
                ExternalPanelDefault.Visible = false;
                InternalPanelHeading.Visible = false;
            }
        }

        public List<Project> GetProjects()
        {
            var dbData = new UserOperationsContext();
            return dbData.Projects.ToList();
        }

        protected void ProjectList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProject")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var projectId = (int)ProjectList.DataKeys[index].Value;
                var dbData = new UserOperationsContext();
                ProjectID.Text = projectId.ToString();
                ProjectName.Text = dbData.Projects.Where(o => o.ProjectId == projectId).FirstOrDefault().ProjectName;
                ModalPopup.Show();
            }
            else if (e.CommandName == "ViewReport")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var projectId = (int)ProjectList.DataKeys[index].Value;
                Response.Redirect("/Admin/ProjectReport?projectId=" + projectId);
            }
        }

        protected void CloseButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = manager.Find(User.Identity.Name, PassTextBox.Text);
            if (user != null)
            {

                var dbData = new UserOperationsContext();
                int Id = Convert.ToInt32(ProjectID.Text);
                var project = dbData.Projects.First(p => p.ProjectId == Id);
                var actions = new ProjectActions();

                actions.ComposeMessage(Id, project.OrganizerUserName, "Cancellazione progetto");
                
                actions.RemoveAllAttachments(Id);
                
                var eventActions = new EventActions();
                project.Events.ForEach(ev => eventActions.RemoveAllAttachments(ev.EventId));

                var interventionActions = new InterventionActions();
                project.Interventions.ForEach(con => interventionActions.RemoveAllAttachments(con.InterventionId));
                project.Interventions.ForEach(co => interventionActions.DeleteAllComments(co.InterventionId));

                dbData.Projects.Remove(project);
                dbData.SaveChanges();
                ViewState["lstProject"] = GetProjects();
                ProjectList.DataSource = (List<Project>)ViewState["lstProject"];
                ProjectList.DataBind();
                Response.Redirect("/Admin/ManageProjects.aspx");
            }
            else
            {
                ErrorDeleteLabel.Visible = true;
                ErrorDeleteLabel.Text = "Password sbagliata";
                ModalPopup.Show();
            }
        }

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
            var result = (List<Project>)ViewState["lstProject"];
            ProjectList.DataSource = result;
            ProjectList.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtDescription.Text = "";
            txtCreationDate.Text = "";
            txtLastModifiedDate.Text = "";
            var result = GetProjects();
            ViewState["lstProject"] = result;
            ProjectList.DataSource = result;
            ProjectList.DataBind();

        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = !filterPanel.Visible;
        }

        private void FilterByName(string name)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.ProjectName.Contains(name)).ToList();
            ViewState["lstProject"] = result;
        }

        private void FilterByDescription(string description)
        {
            var result = (List<Project>)ViewState["lstProject"];
            result = result.Where(p => p.Description.Contains(description)).ToList();
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

        protected void ProjectList_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;

            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            ProjectList.DataSource = GetSortedData(e.SortExpression);
            ProjectList.DataBind();
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

        public string GetDescription(string description)
        {
            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            doc.LoadHtml(description);
            description = doc.DocumentNode.InnerText;
            return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
        }

        protected void ProjectList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ProjectList.PageIndex = e.NewPageIndex;
            ProjectList.DataSource = GetProjects();
            ProjectList.DataBind();
        }

    }
}