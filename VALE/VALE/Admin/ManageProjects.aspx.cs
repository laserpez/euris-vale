﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace VALE.Admin
{
    public partial class ManageProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var lstProject = GetProjects();
                ProjectList.DataSource = lstProject;
                ProjectList.DataBind();
                ViewState["lstProject"] = lstProject;
                filterPanel.Visible = false;
                
            }
        }

        public List<Project> GetProjects()
        {
            var dbData = new UserOperationsContext();
            return dbData.Projects.ToList();
        }

        private void DeleteFolders(List<string> foldersList)
        {
            foreach(var folder in foldersList)
            {
                if(!String.IsNullOrEmpty(folder))
                    Directory.Delete(Server.MapPath(folder), true);
            }
        }

        protected void ProjectList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int projectId = Convert.ToInt32(ProjectList.Rows[index].Cells[0].Text);
            var dbData = new UserOperationsContext();

            if (e.CommandName == "DeleteProject")
            {
                ProjectID.Text = projectId.ToString();
                ProjectName.Text = dbData.Projects.Where(o => o.ProjectId == projectId).FirstOrDefault().ProjectName;
                ModalPopup.Show();
            }
            else
            {
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
                if (!String.IsNullOrEmpty(project.DocumentsPath))
                {
                    if (Directory.Exists(Server.MapPath(project.DocumentsPath)))
                        Directory.Delete(Server.MapPath(project.DocumentsPath), true);
                }
                DeleteFolders(project.Events.Select(ev => ev.DocumentsPath).ToList());
                DeleteFolders(project.Interventions.Select(i => i.DocumentsPath).ToList());
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
                ErrorDeleteLabel.Text = "Wrong password";
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

    }
}