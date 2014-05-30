using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using System.Web.ModelBinding;
using VALE.Logic;
using System.IO;

namespace VALE.MyVale
{
    public partial class EventDetails : System.Web.UI.Page
    {
        private int _currentEventId;
        private string _currentUser;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            if (Request.QueryString.HasKeys())
                _currentEventId = Convert.ToInt32(Request.QueryString["eventId"]);
            _currentUser = User.Identity.GetUserName();
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            Button btnAttend = (Button)EventDetail.FindControl("btnAttend");
            if(IsUserAttendingThisEvent())
            {
                btnAttend.CssClass = "btn btn-success";
                btnAttend.Text = "Already attending";
            }
            else
            {
                btnAttend.CssClass = "btn btn-info";
            }
        }

        private bool IsUserAttendingThisEvent()
        {
            return _db.Events.First(a => a.EventId == _currentEventId).RegisteredUsers.Select(u => u.UserName).Contains(_currentUser);
        }

        public Event GetEvent([QueryString("eventId")] int? eventId)
        {
            if (eventId.HasValue)
                return _db.Events.FirstOrDefault(e => e.EventId == eventId);
            else
                return null;
        }

        public IQueryable<UserData> GetRegisteredUsers([QueryString("eventId")] int? eventId)
        {
            if (eventId.HasValue)
                return _db.Events.Where(e => e.EventId == eventId).FirstOrDefault().RegisteredUsers.AsQueryable();
            else
                return null;
        }

        public Project GetRelatedProject([QueryString("eventId")] int? eventId)
        {
            var project = _db.Events.First(e => e.EventId == eventId).RelatedProject;
            return project;
        }

        protected void btnSearchProject_Click(object sender, EventArgs e)
        {
            FormView fwProject = (FormView)EventDetail.FindControl("ProjectDetail");
            TextBox textBox = (TextBox)fwProject.FindControl("txtProjectName");
            string projectName = textBox.Text;
            Project project = _db.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if (project != null)
            {
                Activity activity = _db.Activities.Where(a => a.ActivityId == _currentEventId).First();
                activity.RelatedProject = project;
                project.Activities.Add(activity);
                _db.SaveChanges();
            }
            else
            {
                Label statusLabel = (Label)fwProject.FindControl("lblResultAddProject");
                statusLabel.Text = "This project does not exists";
            }
        }

        protected void btnAttend_Click(object sender, EventArgs e)
        {
            UserData user = _db.UsersData.First(u => u.UserName == _currentUser);
            Event thisEvent = _db.Events.First(ev => ev.EventId == _currentEventId);
            Button btnAttend = (Button)EventDetail.FindControl("btnAttend");
            if (!IsUserAttendingThisEvent())
            {
                thisEvent.RegisteredUsers.Add(user);
                user.AttendingEvents.Add(thisEvent);
                _db.SaveChanges();
                // MAIL
                //string eventToString = String.Format("{0}\nCreated by:{1}\nDate:{2}\n\n{3}", thisEvent.Name, thisEvent.Organizer.FullName, thisEvent.EventDate, thisEvent.Description);
                //MailHelper.SendMail(user.Email, String.Format("You succesfully registered to event:\n{0}", eventToString), "Event notification");
                //MailHelper.SendMail(user.Email, String.Format("User {0} is now registered to your event:\n{1}", user.FullName, eventToString), "Event notification");
            }
            else
            {
                thisEvent.RegisteredUsers.Remove(user);
                user.AttendingEvents.Remove(thisEvent);
                _db.SaveChanges();
            }


            Response.Redirect("/MyVale/EventDetails.aspx?eventId=" + _currentEventId);
        }

        public List<string> GetRelatedDocuments([QueryString("eventId")] int? eventId)
        {
            var db = new UserOperationsContext();
            var thisEvent = db.Events.First(p => p.EventId == eventId);
            if (!String.IsNullOrEmpty(thisEvent.DocumentsPath))
            {
                var dir = new DirectoryInfo(Server.MapPath(thisEvent.DocumentsPath));
                var files = dir.GetFiles().Select(f => f.Name).ToList();
                if (files.Count == 0)
                    HideListBox("lstDocuments");
                return files;
            }
            else
            {
                HideListBox("lstDocuments");
                return null;
            }
        }


        private void HideListBox(string name)
        {
            ListBox list = (ListBox)EventDetail.FindControl(name);
            list.Visible = false;
        }

        protected void btnViewDocument_Click(object sender, EventArgs e)
        {
            var thisEvent = _db.Events.First(ev => ev.EventId == _currentEventId);
            var lstDocument = (ListBox)EventDetail.FindControl("lstDocuments");
            if(lstDocument.SelectedIndex > -1)
            {
                var file = thisEvent.DocumentsPath + lstDocument.SelectedValue;
                Response.Redirect("/DownloadFile.ashx?filePath=" + file + "&fileName=" + lstDocument.SelectedValue);
            }
        }
    }
}