﻿using System;
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
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.HasKeys())
                _currentEventId = Convert.ToInt32(Request.QueryString.GetValues("eventId").First());
            _currentUserId = User.Identity.GetUserId();


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
            var db = new UserOperationsContext();
            return db.Events.First(a => a.EventId == _currentEventId).RegisteredUsers.Select(u => u.UserDataId).Contains(_currentUserId);
        }

        public Event GetEvent([QueryString("eventId")] int? eventId)
        {
            var db = new UserOperationsContext();
            if (eventId.HasValue)
            {
                _currentEventId = (int)eventId;
                return db.Events.FirstOrDefault(e => e.EventId == eventId);
            }
            else
                return null;
        }

        public IQueryable<UserData> GetRegisteredUsers([QueryString("eventId")] int? eventId)
        {
            if (eventId.HasValue)
            {
                var db = new UserOperationsContext();
                var listUsers = db.Events.Where(e => e.EventId == eventId).FirstOrDefault().RegisteredUsers.AsQueryable();
                return listUsers;
            }
            else
                return null;
        }

        public Project GetRelatedProject([QueryString("eventId")] int? eventId)
        {
            var db = new UserOperationsContext();
            var project = db.Projects
                .Where(p => p.ProjectId == db.Events
                    .Where(a => a.EventId == eventId)
                    .Select(a => a.RelatedProject.ProjectId).FirstOrDefault()).FirstOrDefault();
            return project;
        }

        protected void btnSearchProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            FormView fwProject = (FormView)EventDetail.FindControl("ProjectDetail");
            TextBox textBox = (TextBox)fwProject.FindControl("txtProjectName");
            string projectName = textBox.Text;
            Project project = dbData.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if (project != null)
            {
                Activity activity = dbData.Activities.Where(a => a.ActivityId == _currentEventId).First();
                activity.RelatedProject = project;
                project.Activities.Add(activity);
                dbData.SaveChanges();
            }
            else
            {
                Label statusLabel = (Label)fwProject.FindControl("lblResultAddProject");
                statusLabel.Text = "This project does not exists";
            }
        }

        protected void btnAttend_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            UserData user = db.UsersData.First(u => u.UserDataId == _currentUserId);
            Event thisEvent = db.Events.First(ev => ev.EventId == _currentEventId);
            Button btnAttend = (Button)EventDetail.FindControl("btnAttend");
            if (!IsUserAttendingThisEvent())
            {
                thisEvent.RegisteredUsers.Add(user);
                user.AttendingEvents.Add(thisEvent);
                db.SaveChanges();
                // MAIL
                //string eventToString = String.Format("{0}\nCreated by:{1}\nDate:{2}\n\n{3}", thisEvent.Name, thisEvent.Organizer.FullName, thisEvent.EventDate, thisEvent.Description);
                //MailHelper.SendMail(user.Email, String.Format("You succesfully registered to event:\n{0}", eventToString), "Event notification");
                //MailHelper.SendMail(user.Email, String.Format("User {0} is now registered to your event:\n{1}", user.FullName, eventToString), "Event notification");
            }
            else
            {
                thisEvent.RegisteredUsers.Remove(user);
                user.AttendingEvents.Remove(thisEvent);
                db.SaveChanges();
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

        

    }
}