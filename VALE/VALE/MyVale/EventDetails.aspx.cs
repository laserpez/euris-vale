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
using VALE.MyVale.Create;

namespace VALE.MyVale
{
    public partial class EventDetails : Page
    {
        private int _currentEventId;
        private string _currentUserName;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _db = new UserOperationsContext();
            if (Request.QueryString.HasKeys())
                _currentEventId = Convert.ToInt32(Request.QueryString["eventId"]);
            _currentUserName = User.Identity.GetUserName();

            if (!IsPostBack)
            {
                if (Request.QueryString["From"] != null)
                    Session["EventDetailsRequestFrom"] = Request.QueryString["From"];
                var currentEvent = _db.Events.FirstOrDefault(ev => ev.EventId == _currentEventId);
                var addUsersBtn = EventDetail.FindControl("btnAddUsers");
                var btnModify = (Button)EventDetail.FindControl("btnModifyEvent");
                if (currentEvent.OrganizerUserName == _currentUserName || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio"))
                {
                    addUsersBtn.Visible = true;
                    btnModify.Visible = true;
                }
                if (_currentUserName != currentEvent.OrganizerUserName || !RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
                {
                    var btnAddRelatedProject = (Button)EventDetail.FindControl("btnAddRelatedProject");
                    btnAddRelatedProject.Visible = false;
                    var btnDeleteRelatedProject = (Button)EventDetail.FindControl("btnDeleteRelatedProject");
                    btnDeleteRelatedProject.Visible = false;

                }
                if (Request.QueryString["From"] != null)
                    Session["EventDetailsRequestFrom"] = Request.QueryString["From"];
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Eventi"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina EventDetails.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            setBtnAttend();
        }

        public string GetStatusOfEventRequest(UserData user)
        {
            var Event = _db.Events.FirstOrDefault(e => e.EventId == _currentEventId);
            if (Event.PendingUsers.FirstOrDefault(u => u.UserName == user.UserName) != null)
                return "In Attesa";
            return "Partecipa";

        }
        public void setBtnAttend()
        {
            var eventActions = new EventActions();
            if (eventActions.IsUserRelated(_currentEventId, _currentUserName))
            {
                btnAttend.CssClass = "btn btn-success";
                btnAttend.Text = "Stai partecipando";
            }
            else
            {
                btnAttend.CssClass = "btn btn-info"; 
                btnAttend.Text = "Partecipa";

                var userActions = new UserActions();
                if (RoleActions.checkPermission(_currentUserName, "Amministrazione") == false)
                {
                    if (_db.Events.FirstOrDefault(ev => ev.EventId == _currentEventId && ev.OrganizerUserName != _currentUserName).Public == false)
                        Response.Redirect("/MyVale/Events.aspx");
                }
            }
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
            {
                var Event = _db.Events.Where(e => e.EventId == eventId.Value).FirstOrDefault();
                if (Event != null)
                {
                    var users = Event.RegisteredUsers;
                    users.AddRange(Event.PendingUsers);
                    return users.AsQueryable();
                }
            }
            return null;
                
        }

        protected void btnAttend_Click(object sender, EventArgs e)
        {
            Button btnAttend = (Button)EventDetail.FindControl("btnAttend");
            var eventActions = new EventActions();
            eventActions.AddOrRemoveUserData(_currentEventId, _currentUserName, "user");
            setBtnAttend();
        }

        protected void EventDetail_DataBound(object sender, EventArgs e)
        {
            FileUploader uploader = (FileUploader)EventDetail.FindControl("FileUploader");
            uploader.DataActions = new EventActions();
            uploader.DataId = _currentEventId;
            if (!IsPostBack)
                uploader.DataBind();

            var db = new UserOperationsContext();
            string result = db.Events.First(b => b.EventId == _currentEventId).Description;
            Label lblContent = (Label)EventDetail.FindControl("lblContent");
            lblContent.Text = result;
        }

        protected void addUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + _currentEventId + "&dataType=event&returnUrl=/MyVale/EventDetails?eventId=" +_currentEventId);
        }

        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ModalPopupEvent.Hide();
        }

        protected void btnModifyEvent_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var events = db.Events.Where(o => o.EventId == _currentEventId).FirstOrDefault();
            btnClosePopUpButton.Visible = true;
            txtName.Enabled = true;
            txtName.Text = events.Name;
            txtDescription.Text = events.Description;
            txtStartDate.Text = events.EventDate.ToShortDateString();
            txtHour.Text = events.EventDate.Hour.ToString("00");
            txtMin.Text = events.EventDate.Minute.ToString("00");
            txtDurata.Text = events.Durata.ToString();
            txtSite.Text = events.Site;
            chkPublic.Checked = events.Public;
            ModalPopupEvent.Show();
        }

        protected void btnConfirmModify_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var events = db.Events.Where(o => o.EventId == _currentEventId).FirstOrDefault();
            events.Name = txtName.Text;
            events.Description = txtDescription.Text;
            events.EventDate = Convert.ToDateTime(txtStartDate.Text+" "+txtHour.Text+":"+txtMin.Text);
            events.Durata = txtDurata.Text;
            events.Site =  txtSite.Text;
            events.Public = chkPublic.Checked;

            if (events.RelatedProject != null)
            {
                events.RelatedProject.LastModified = DateTime.Now;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(events.RelatedProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
            }

            db.SaveChanges();
            Response.Redirect("~/MyVale/EventDetails.aspx?eventId="+_currentEventId);
        }

        //++++++++++++++++++++++++++RelatedProject+++++++++++++++++++++++++++++++++
        protected void btnDeleteRelatedProject_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Hide();
            var Event = _db.Events.First(a => a.EventId == _currentEventId);
            var projectRelated = _db.Projects.FirstOrDefault(p => p.ProjectId == Event.ProjectId);

            var eventActions = new EventActions();
            eventActions.ComposeMessage(_currentEventId, projectRelated.OrganizerUserName, "Rimosso progetto correlato");

            projectRelated.Events.Remove(Event);
            projectRelated.LastModified = DateTime.Now;
            var actions = new ProjectActions();
            var listHierarchyUp = actions.getHierarchyUp(projectRelated.ProjectId);
            if (listHierarchyUp.Count != 0)
                listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);

            _db.SaveChanges();
            GridView grdRelatedProject = (GridView)EventDetail.FindControl("grdRelatedProject");
            grdRelatedProject.DataBind();
        }

        protected void btnAddRelatedProject_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Show();
        }

        public IQueryable<Project> GetProjects()
        {
            var _db = new UserOperationsContext();
            return _db.Projects.Where(pr => pr.Status != "Chiuso").OrderBy(p => p.ProjectName);
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Hide();
        }

        protected void btnChooseProject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            var project = _db.Projects.FirstOrDefault(p => p.ProjectName == btn.CommandArgument);
            if (project != null)
            {
                var Event = _db.Events.First(a => a.EventId == _currentEventId);
                Event.RelatedProject = project;

                var eventActions = new EventActions();
                eventActions.ComposeMessage(_currentEventId, project.OrganizerUserName, "Aggiunto progetto correlato");

                project.LastModified = DateTime.Now;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(project.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);

                _db.SaveChanges();
                GridView grdRelatedProject = (GridView)EventDetail.FindControl("grdRelatedProject");
                grdRelatedProject.DataBind();
                Response.Redirect("/MyVale/EventDetails?eventId=" + _currentEventId);
            }

        }

        //Devono essere gestiti i vincoli per la modifica : amministratore/utente normale/creatore dell'attività
        public IQueryable<Project> GetRelatedProject([QueryString("eventId")] int? eventId)
        {
            ModalPopupListProject.Hide();
            if (eventId.HasValue)
            {
                Button btnModifyRelatedProject = (Button)EventDetail.FindControl("btnModifyRelatedProject");
                Button btnDeleteRelatedProject = (Button)EventDetail.FindControl("btnDeleteRelatedProject");
                Button btnAddRelatedProject = (Button)EventDetail.FindControl("btnAddRelatedProject");
                var Event = _db.Events.First(a => a.EventId == _currentEventId);
                var project = Event.RelatedProject;
                if (project != null)
                {
                    btnDeleteRelatedProject.Visible = true;
                    btnAddRelatedProject.Visible = false;
                    var list = new List<Project> { project };
                    return list.AsQueryable();
                }
                else
                {
                    btnDeleteRelatedProject.Visible = false;
                    btnAddRelatedProject.Visible = true;
                }
            }
            return null;
        }

        public string GetDescription(string description)
        {
            if (!String.IsNullOrEmpty(description))
            {
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(description);
                description = doc.DocumentNode.InnerText;
                return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
            }
            else
            {
                return "Nessuna descrizione presente";
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            string returnUrl = "";
            if (Session["EventDetailsRequestFrom"] != null)
                returnUrl = Session["EventDetailsRequestFrom"].ToString();
            else
                returnUrl = "/MyVale/Events";
            Session["EventDetailsRequestFrom"] = null;
            Response.Redirect(returnUrl);
        }
     
    }
}