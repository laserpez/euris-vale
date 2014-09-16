using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;
using System.Linq.Expressions;

namespace VALE.MyVale
{
    public partial class Events : Page
    {
        private string _currentUserName;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUserName = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                EventActions actions = new EventActions();
                if (actions.GetEventRequests().Count > 0)
                {
                    btnList.InnerHtml = " Richieste <span class=\"caret\">";
                    EventsListType.Text = "RequestEvents";
                    RequestMode();
                }
                else
                    EventMode();
                grdEvents.DataBind();
            }
            
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneEventi"))
                    btnAddEvent.Visible = false;
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Eventi"))
            {
                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina Events.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public int GetPendingEventsCount()
        {
            return 0;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            string id = grdEvents.DataKeys[rowID].Value.ToString();
            Response.Redirect("/MyVale/EventDetails?eventId=" + id + "&From=~/MyVale/Events");
        }

        protected void btnAttendEvent_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            int eventId = (int)grdEvents.DataKeys[rowID].Value;
 
            var eventActions = new EventActions();
            eventActions.AddOrRemoveUserData(eventId, _currentUserName, "user");
            grdEvents.DataBind();
        }

        protected void txtFromDate_TextChanged(object sender, EventArgs e)
        {
            SetCalendarDateTo();
        }

        private void SetCalendarDateTo()
        {
            
            DateTime valueFrom = DateTime.MinValue;
            bool successFrom = DateTime.TryParse(txtFromDate.Text, out valueFrom);
            if (successFrom)
            {
                calendarTo.StartDate = valueFrom;
                DateTime valueTo = DateTime.MaxValue;
                bool successTo = DateTime.TryParse(txtToDate.Text, out valueTo);
                if (successTo)
                {
                    if (valueFrom > valueTo)
                        txtToDate.Text = "";
                }
                else
                    txtToDate.Text = "";
            }
            else
                calendarTo.StartDate = DateTime.MinValue;
        }

        //private void ChangeCalendars()
        //{
        //    if (txtFromDate.Text != "" && CheckDate())
        //    {
        //        calendarTo.StartDate = Convert.ToDateTime(txtFromDate.Text);
        //    }
        //    if (txtFromDate.Text == "")
        //    {
        //        txtToDate.Text = "";
        //    }
        //}

        //private bool CheckDate()
        //{
        //    if (!String.IsNullOrEmpty(txtToDate.Text))
        //    {
        //        var startDate = Convert.ToDateTime(txtFromDate.Text);
        //        var endDate = Convert.ToDateTime(txtToDate.Text);
        //        if (startDate > endDate)
        //        {
        //            txtToDate.Text = "";
        //            calendarTo.StartDate = Convert.ToDateTime(txtFromDate.Text);
        //            return false;
        //        }
        //    }
        //    return true;
        //}

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            if (filterPanel.Visible)
                HideFilters();
                
            else
                ShowFilters();
        }

        private void ShowFilters() 
        {
            filterPanel.Visible = true;
            btnFilterEvents.Visible = true;
            btnClearFilters.Visible = true;
            btnShowFilters.Text = "Nascondi filtri";
        }

        private void HideFilters()
        {
            filterPanel.Visible = false;
            btnFilterEvents.Visible = false;
            btnClearFilters.Visible = false;
            btnShowFilters.Text = "Visualizza filtri";
        }

        public List<Project> GetProjects()
        {
            var db = new UserOperationsContext();
            List<Event> events = db.Events.Where(e => e.RelatedProject != null).ToList();
            if (! RoleActions.checkPermission(_currentUserName, "Amministrazione"))
                events = events.Where(ev => ev.Public == true || (ev.OrganizerUserName == _currentUserName || ev.RegisteredUsers.FirstOrDefault(u => u.UserName == _currentUserName) != null)).ToList();
            if (lblAllOrPersonal.Text == "Personal")
                events = events.Where(ev => ev.OrganizerUserName == _currentUserName || ev.RegisteredUsers.FirstOrDefault(u => u.UserName == _currentUserName) != null).ToList();
            var projects = events.Select(e => e.RelatedProject).ToList();
            projects.Insert(0, new Project { ProjectName = "-- Tutti Progetti --", ProjectId = 0 });
            return projects;
        }

        protected void ddlSelectProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            grdEvents.DataBind();
        }

        protected void btnFilterEvents_Click(object sender, EventArgs e)
        {
            grdEvents.DataBind();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = "";
            txtToDate.Text = "";
            grdEvents.DataBind();
        }

        

        public IQueryable<Event> grdEvents_GetData()
        {
            var db = new UserOperationsContext();
            List<Event> events = new List<Event>();
            if (EventsListType.Text == "RequestEvents")
            {
                EventActions actions = new EventActions();
                events = actions.GetEventRequests();
            }
            else 
            {
                if (RoleActions.checkPermission(_currentUserName, "Amministrazione"))
                    events = db.Events.ToList();
                else
                    events = db.Events.Where(ev => ev.Public == true || (ev.OrganizerUserName == _currentUserName || ev.RegisteredUsers.FirstOrDefault(u => u.UserName == _currentUserName) != null)).ToList();

                if (lblAllOrPersonal.Text == "Personal")
                    events = events.Where(ev => ev.OrganizerUserName == _currentUserName || ev.RegisteredUsers.FirstOrDefault(u => u.UserName == _currentUserName) != null).ToList();
                if (EventsListType.Text == "ProjectEvents")
                {
                    if (ddlSelectProject.SelectedIndex > 0)
                    {
                        int projectId = Convert.ToInt32(ddlSelectProject.SelectedValue);
                        events = events.Where(e => e.RelatedProject != null && e.RelatedProject.ProjectId == projectId).ToList();
                    }
                    else 
                    {
                        events = events.Where(e => e.RelatedProject != null).ToList();
                    }
                    
                }
                else if (EventsListType.Text == "NotRelatedEvents")
                {
                    events = events.Where(ev => ev.RelatedProject == null).ToList();
                }
            }
            
            if(!string.IsNullOrEmpty(txtFromDate.Text))
            {
                var dateFrom = Convert.ToDateTime(txtFromDate.Text);
                events = events.Where(ev => ev.EventDate >= dateFrom).ToList();
            }
               
           
            if(!string.IsNullOrEmpty(txtToDate.Text))
            {
                var dateTo = Convert.ToDateTime(txtToDate.Text);
                events = events.Where(ev => ev.EventDate <= dateTo).ToList();
            }

           
            return events.AsQueryable();
        }

        protected void ChangeSelectedEvents_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            
            btnList.InnerHtml = GetButtonName(button.Text) + " <span class=\"caret\">";
            HeaderName.Text = GetButtonName(button.Text);
            switch (button.CommandArgument)
            {
                case "AllEvents":
                    EventsListType.Text = "AllEvents";
                    EventMode();
                    break;
                case "ProjectEvents":
                    EventsListType.Text = "ProjectEvents";
                    EventMode();
                   
                    break;
                case "NotRelatedEvents":
                    EventsListType.Text = "NotRelatedEvents";
                    EventMode();
                    break;
                case "RequestEvents":
                    EventsListType.Text = "RequestEvents";
                    RequestMode();
                    break;
            }
            grdEvents.DataBind();

        }

        private void RequestMode() 
        {
            btnPersonal.Visible = false;
            btnAllUsers.Visible = false;
            projectPanel.Visible = false;
            HideFilters();
            txtFromDate.Text = "";
            txtToDate.Text = "";
            grdEvents.Columns[3].Visible = false;
            grdEvents.Columns[4].Visible = true;
            grdEvents.Columns[5].Visible = true;
            grdEvents.Columns[6].Visible = false;

        }

        private void EventMode()
        {
            projectPanel.Visible = false;
            btnAllOrPersonal.Visible = true;
            if (EventsListType.Text == "ProjectEvents") 
            {
                projectPanel.Visible = true;
                ShowFilters();
            }
            grdEvents.Columns[3].Visible = true;
            grdEvents.Columns[4].Visible = false;
            grdEvents.Columns[5].Visible = false;
            grdEvents.Columns[6].Visible = true;
            if (lblAllOrPersonal.Text == "Personal")
            {
                btnPersonal.Visible = true;
                btnAllUsers.Visible = false;
            }
            else 
            {
                btnPersonal.Visible = false;
                btnAllUsers.Visible = true;
            }
           
            
        }
        private string GetButtonName(string html)
        {
            string[] lineTokens = html.Split('>');
            return lineTokens[2].Trim();
        }

        public bool IsUserRelated(int eventId)
        {
            var eventActions = new EventActions();
            return eventActions.IsUserRelated(eventId, _currentUserName);
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

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/EventCreate?From=~/MyVale/Events");
        }

        protected void btnPersonalLinkButton_Click(object sender, EventArgs e)
        {
            lblAllOrPersonal.Text = "Personal";
            btnPersonal.Visible = true;
            btnAllUsers.Visible = false;
            grdEvents.DataBind();
        }

        protected void btnAllUsersLinkButton_Click(object sender, EventArgs e)
        {
            lblAllOrPersonal.Text = "All";
            btnPersonal.Visible = false;
            btnAllUsers.Visible = true;
            grdEvents.DataBind();
        }

        protected void grdEvents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            EventActions actions = new EventActions();
            string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
            if (e.CommandName == "AcceptEvent") 
            {
                int eventId = Convert.ToInt32(e.CommandArgument);
                actions.AcceptEvent(eventId);
                Response.Redirect(pageUrl);
            }
            else if (e.CommandName == "RejectEvent") 
            {
                int eventId = Convert.ToInt32(e.CommandArgument);
                actions.RejectEvent(eventId);
                Response.Redirect(pageUrl);
            }
        }

    }
}