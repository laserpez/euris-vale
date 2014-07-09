using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class ProjectCreate : System.Web.UI.Page
    {
        private string _currentUser;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                chkPublic.Checked = true;
            }
        }

        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();

            var RelatedProjectSelected = dbData.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text);
            if (SelectProject.ProjectNameTextBox.Text != "" && RelatedProjectSelected == null)
            {
                ModelState.AddModelError("", "Nome Progetto Correlato errato");
            }
            else if (dbData.Projects.Where(o => o.ProjectName == txtName.Text).FirstOrDefault() != null)
            {
                ModelState.AddModelError("", "Nome Progetto già esistente");
            }
            else
            {

                var project = new Project
                {
                    CreationDate = Convert.ToDateTime(txtStartDate.Text),
                    OrganizerUserName = _currentUser,
                    Description = txtDescription.Text,
                    ProjectName = txtName.Text,
                    LastModified = Convert.ToDateTime(txtStartDate.Text),
                    Status = "Aperto",
                    Public = chkPublic.Checked,
                    Activities = new List<Activity>(),
                    Events = new List<Event>(),
                    InvolvedUsers = new List<UserData>(),
                    RelatedProject = dbData.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text),
                };

                var projectActions = new ProjectActions();
                projectActions.SaveData(project, dbData);
                Response.Redirect("~/MyVale/Projects");
            }
        }

        protected void btnAddUsers_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();

            var RelatedProjectSelected = dbData.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text);
            if (SelectProject.ProjectNameTextBox.Text != "" && RelatedProjectSelected == null)
            {
                ModelState.AddModelError("", "Nome Progetto errato");
            }
            else
            {

                var project = new Project
                {
                    CreationDate = Convert.ToDateTime(txtStartDate.Text),
                    OrganizerUserName = _currentUser,
                    Description = txtDescription.Text,
                    ProjectName = txtName.Text,
                    LastModified = Convert.ToDateTime(txtStartDate.Text),
                    Status = "Aperto",
                    Public = chkPublic.Checked,
                    Activities = new List<Activity>(),
                    Events = new List<Event>(),
                    InvolvedUsers = new List<UserData>(),
                    RelatedProject = dbData.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text),
                };

                var projectActions = new ProjectActions();
                projectActions.SaveData(project, dbData);
                Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + project.ProjectId + "&dataType=project&returnUrl=/MyVale/Projects");
            }
        }

    }
}