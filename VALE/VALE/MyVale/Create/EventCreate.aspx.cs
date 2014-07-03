using System;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                if (Request.QueryString["ProjectId"] != null)
                    Session["callingProjectId"] = Request.QueryString["ProjectId"];
                else
                    Session["callingProjectId"] = null;
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

        protected void btnAddUsers_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var user = db.UserDatas.FirstOrDefault(u => u.UserName == _currentUser);
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

            var redirectURL = "";
            if (Session["callingProjectId"] != null)
                redirectURL = "/MyVale/ProjectDetails?projectId=" + Session["callingProjectId"].ToString();
            else if (Session["requestFrom"] != null)
                redirectURL = Session["requestFrom"].ToString();
            else
                redirectURL = "/MyVale/Events";

            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + newEvent.EventId + "&dataType=event&returnUrl=" + redirectURL);
        }
    }
}