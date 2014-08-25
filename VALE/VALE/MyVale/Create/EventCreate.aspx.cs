﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using System.IO;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class EventCreate : Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                txtHour.Text = "00";
                txtMin.Text = "00";
                chkPublic.Checked = true;
                if (Request.QueryString["ProjectId"] != null)
                    Session["EventCreateCallingProjectId"] = Request.QueryString["ProjectId"];
                if (Request.QueryString["From"] != null)
                    Session["EventCreateRequestFrom"] = Request.QueryString["From"];
                calendarFrom.StartDate = DateTime.Now;
            }

            if (Session["EventCreateCallingProjectId"] != null)
            {
                var db = new UserOperationsContext();
                var projectId = Convert.ToInt32(Session["EventCreateCallingProjectId"].ToString());
                var projectName = db.Projects.First(p => p.ProjectId == projectId).ProjectName;
                SelectProject.DisableControl(projectName);
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneEventi"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina EventCreate.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        protected void btnAddUsers_Click(object sender, EventArgs e)
        {
            var newEvent = SaveData();

            if (newEvent.Public == true)
                SendMailToAll(newEvent);

            var redirectURL = "";
            var fromRequest = "";
            if (Session["EventCreateCallingProjectId"] != null)
            {
                redirectURL = "/MyVale/ProjectDetails?projectId=" + Session["EventCreateCallingProjectId"].ToString();
                fromRequest = "project";
                Session["EventCreateCallingProjectId"] = null;
            }
            else if (Session["EventCreateRequestFrom"] != null)
            {
                redirectURL = Session["EventCreateRequestFrom"].ToString();
                Session["EventCreateRequestFrom"] = null;
            }
            else
                redirectURL = "/MyVale/Events";

            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + newEvent.EventId + "&dataType=event&returnUrl=" + redirectURL + "&requestFrom=" + fromRequest);
        }

        private void SendMailToAll(Event newEvent)
        {
            var db = new UserOperationsContext();
            List<UserData> listAllUsers = db.UserDatas.Where(ev => ev.UserName != _currentUser).ToList();
            if (listAllUsers.Count != 0)
            {
                foreach(var user in listAllUsers)
                {
                    var subjectMail = "Creazione di un nuovo evento pubblico";
                    var bodyMail = "Salve, ti informiamo che in data " + newEvent.EventDate.ToShortDateString() + 
                        " si terrà l'evento " + newEvent.Name + ", organizzato da " + newEvent.OrganizerUserName + 
                        ", alle ore " + newEvent.EventDate.ToShortTimeString() + " in " + newEvent.Site + ".<br/> L'evento avrà una durata di " + newEvent.Durata + " ore.<br/>"
                        + "La partecipazione è pubblica.<br/>" +
                         "Per maggiori informazioni <a href=\" http://localhost:59959/MyVale/EventDetails?EventId=" + newEvent.EventId + "\">Clicca qui<a/>";
                    Mail newMail = new Mail (to: user.Email, bcc: "", cc: "", subject: subjectMail, body: bodyMail, form: "Evento" );

                    var helper = new MailHelper();
                    int queueId = helper.AddToQueue(newMail);
                    helper.WriteLog(newMail, queueId);
                }
            }
        }

        private Event SaveData()
        {
            var db = new UserOperationsContext();
            var user = db.UserDatas.FirstOrDefault(u => u.UserName == _currentUser);
            var registeredUsers = new List<UserData>() { user };
            var dateToAdd = new DateTime();
            int hour, minute;
            int.TryParse(txtHour.Text, out hour);
            int.TryParse(txtMin.Text, out minute);
            if (hour <= 0 || hour > 24)
                hour = 0;
            if (minute < 0 || minute > 59)
                minute = 0;

            dateToAdd = Convert.ToDateTime(txtStartDate.Text + " " + hour + ":" + minute);

            var project = db.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text);

            var newEvent = new Event
            {
                Name = txtName.Text,
                Description = txtDescription.Text,
                Site = txtSite.Text,
                Durata = txtDurata.Text,
                Public = chkPublic.Checked,
                EventDate = dateToAdd,
                OrganizerUserName = _currentUser,
                RegisteredUsers = registeredUsers,
                RelatedProject = project
            };
            var eventActions = new EventActions();

            eventActions.SaveData(newEvent, db);

            return newEvent;
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            var newEvent = SaveData();

            if (newEvent.Public == true)
                SendMailToAll(newEvent);

            var redirectURL = "";
            if (Session["EventCreateCallingProjectId"] != null)
            {
                var actions = new ProjectActions();
                int projectId = Convert.ToInt32(Session["EventCreateCallingProjectId"].ToString());
                actions.ComposeMessage(projectId, "", "Aggiunto Evento");

                redirectURL = "/MyVale/ProjectDetails?projectId=" + Session["EventCreateCallingProjectId"].ToString();
                Session["EventCreateCallingProjectId"] = null;
            }
            else if (Session["EventCreateRequestFrom"] != null)
            {
                redirectURL = Session["EventCreateRequestFrom"].ToString();
                Session["EventCreateRequestFrom"] = null;
            }
            else
                redirectURL = "/MyVale/Events";
            Response.Redirect(redirectURL);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            var redirectURL = "";
            if (Session["EventCreateCallingProjectId"] != null)
            {
                redirectURL = "/MyVale/ProjectDetails?projectId=" + Session["EventCreateCallingProjectId"].ToString();
                Session["EventCreateCallingProjectId"] = null;
            }
            else if (Session["EventCreateRequestFrom"] != null)
            {
                redirectURL = Session["EventCreateRequestFrom"].ToString();
                Session["EventCreateRequestFrom"] = null;
            }
            else
                redirectURL = "/MyVale/Events";
            Response.Redirect(redirectURL);
        }
    }
}