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
        private string _temporaryPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            _temporaryPath = "/MyVale/Documents/Temp/" + _currentUser + "/";
            
            if (!IsPostBack)
            {
                if (!String.IsNullOrEmpty(_temporaryPath))
                {
                    if (Directory.Exists(Server.MapPath(_temporaryPath)))
                        Directory.Delete(Server.MapPath(_temporaryPath), true);
                    Directory.CreateDirectory(Server.MapPath(_temporaryPath));
                }
                var usersList = new List<string>();
                ViewState["usersIds"] = usersList;
                PopulateGridView();
                calendarFrom.StartDate = DateTime.Now;
            }
        }

        public List<UserData> GetUsers(UserOperationsContext db)
        {
            List<string> userIds = (List<string>)ViewState["usersIds"];
            return db.UsersData.Where(u => userIds.Contains(u.UserName)).ToList();
        }

        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();


            var listUser = new List<UserData>();
            listUser.Add(dbData.UsersData.First(u => u.UserName == _currentUser));
            listUser.AddRange(GetUsers(dbData));


            var project = new Project
            {
                CreationDate = Convert.ToDateTime(txtStartDate.Text),
                OrganizerUserName = _currentUser,
                Description = txtDescription.Text,
                ProjectName = txtName.Text,
                LastModified = Convert.ToDateTime(txtStartDate.Text),
                Status = "open",
                Activities = new List<Activity>(),
                Events = new List<Event>(),
                InvolvedUsers = listUser,
                RelatedProject = dbData.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text),
            };
            dbData.Projects.Add(project);
            dbData.SaveChanges();

            project.DocumentsPath = "/MyVale/Documents/Projects/" + project.ProjectId + "/";
            string serverPath = Server.MapPath(project.DocumentsPath);
            string tempPath = Server.MapPath(_temporaryPath);
            if (!Directory.Exists(Server.MapPath("/MyVale/Documents/Projects/")))
                Directory.CreateDirectory(Server.MapPath("/MyVale/Documents/Projects/"));
            Directory.Move(tempPath, serverPath);
            dbData.SaveChanges();
            Response.Redirect("/MyVale/Projects");
        }

        protected void btnSearchProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            string projectName = txtProjectName.Text;
            Project project = dbData.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if (project != null)
            {
                lblResultSearchProject.Text = String.Format("This event is now related to project {0}", txtProjectName.Text);
                btnSearchProject.CssClass = "btn btn-success";
            }
            else
            {
                lblResultSearchProject.Text = "This project does not exist";
                btnSearchProject.CssClass = "btn btn-warning";
            }
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            string userName = txtUserName.Text;
            var user = db.UsersData.FirstOrDefault(p => p.FullName == userName);
            if (user != null)
            {
                lblResultSearchUser.Text = String.Format("User {0} is now related to this project", txtUserName.Text);
                btnSearchUser.CssClass = "btn btn-success";
                List<string> users = (List<string>)ViewState["usersIds"];
                users.Add(user.UserName);
                ViewState["usersIds"] = users;
                lstUsers.DataBind();
            }
            else
            {
                lblResultSearchUser.Text = "This user does not exist";
                btnSearchUser.CssClass = "btn btn-warning";
            }
            txtUserName.Text = "";
        }

        public IQueryable<UserData> GetRelatedUsers()
        {
            List<string> userIds = (List<string>)ViewState["usersIds"];
            var db = new UserOperationsContext();
            return db.UsersData.Where(u => userIds.Contains(u.UserName));
        }

        public void DeleteUser(ApplicationUser user)
        {
            List<string> users = (List<string>)ViewState["usersIds"];
            users.Remove(user.Id);
            ViewState["usersIds"] = users;
        }

        protected void btnUploadFile_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFiles)
            {
                FileUploadControl.SaveAs(Server.MapPath(_temporaryPath + Path.GetFileName(FileUploadControl.PostedFile.FileName)));
            }
            PopulateGridView();
        }


        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            int index = Convert.ToInt32(e.CommandArgument);
            string fileToRemove = grid.Rows[index].Cells[1].Text;
            File.Delete(Server.MapPath(_temporaryPath) + fileToRemove);
            PopulateGridView();
        }

        private void PopulateGridView()
        {
            DirectoryInfo dirInfo = new DirectoryInfo(Server.MapPath(_temporaryPath));
            if (dirInfo.Exists)
                grdFilesUploaded.DataSource = dirInfo.GetFiles().Select(o => new { Filename = o.Name });
            else
                grdFilesUploaded.DataSource = null;
            grdFilesUploaded.DataBind();
        }
    }
}
