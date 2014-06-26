﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using System.IO;

namespace VALE.MyVale
{
    public partial class EventCreate : System.Web.UI.Page
    {
        private string _currentUser;
        private string _temporaryPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            _temporaryPath = "/MyVale/Documents/Temp/" + _currentUser + "/";
            if (!IsPostBack)
            {
                if (Request.QueryString["ProjectId"] != null)
                    Session["callingProjectId"] = Request.QueryString["ProjectId"];
                else
                    Session["callingProjectId"] = null;

                if (!String.IsNullOrEmpty(_temporaryPath))
                {
                    if (Directory.Exists(Server.MapPath(_temporaryPath)))
                        Directory.Delete(Server.MapPath(_temporaryPath), true);
                    Directory.CreateDirectory(Server.MapPath(_temporaryPath));
                }
                PopulateGridView();
                calendarFrom.StartDate = DateTime.Now;
            }

            if (Session["callingProjectId"] != null)
            {
                var db = new UserOperationsContext();
                var projectId = Convert.ToInt32(Session["callingProjectId"].ToString());
                var projectName = db.Projects.First(p => p.ProjectId == projectId).ProjectName;
                SelectProject.DisableControl(projectName);
            }
        }

        protected void btnSaveEvent_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var user = db.UsersData.FirstOrDefault(u => u.UserName == _currentUser);
            var registeredUsers = new List<UserData>() { user };
            var newEvent = new Event
            {
                Name = txtName.Text,
                Description = txtDescription.Text,
                Public = chkPublic.Checked,
                EventDate = Convert.ToDateTime(txtStartDate.Text),
                OrganizerUserName = _currentUser,
                RegisteredUsers = registeredUsers,
                RelatedProject = db.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text)
            };
            db.Events.Add(newEvent);
            db.SaveChanges();

            newEvent.DocumentsPath = "/MyVale/Documents/Events/" + newEvent.EventId + "/";
            string serverPath = Server.MapPath(newEvent.DocumentsPath);
            string tempPath = Server.MapPath(_temporaryPath);
            if (!Directory.Exists(Server.MapPath("/MyVale/Documents/Events/")))
                Directory.CreateDirectory(Server.MapPath("/MyVale/Documents/Events/"));
            Directory.Move(tempPath, serverPath);
            db.SaveChanges();

            if (Session["callingProjectId"] != null)
                Response.Redirect("/MyVale/ProjectDetails?projectId=" + Session["callingProjectId"].ToString());
            else if (Session["requestFrom"] != null)
                Response.Redirect(Session["requestFrom"].ToString());
            else
                Response.Redirect("/MyVale/Events");
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