using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;

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
                var usersList = new List<string>();
                ViewState["usersIds"] = usersList;
                calendarFrom.StartDate = DateTime.Now;
            }
        }

        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();

            var users = dbData.UsersData.Where(u => SelectUser.SelectedUsers.Contains(u.UserName)).ToList();

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
                InvolvedUsers = users,
                RelatedProject = dbData.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text),
            };
            dbData.Projects.Add(project);
            dbData.SaveChanges();
            Response.Redirect("/MyVale/Projects");
        }
    }
}