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
    public partial class Events : System.Web.UI.Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            
            if (!IsPostBack)
            {
                var dbData = new UserOperationsContext();
                var events = dbData.Events.ToList();
                ViewState["lstEvent"] = events;

                PopulateGridView(DateTime.Today, DateTime.Today.AddDays(7));
                txtFromDate.Text = DateTime.Today.ToShortDateString();
                txtToDate.Text = DateTime.Today.AddDays(7).ToShortDateString(); 
            }
        }

        protected void btnShowEvents_Click(object sender, EventArgs e)
        {
            DateTime from = Convert.ToDateTime(txtFromDate.Text);
            DateTime to = Convert.ToDateTime(txtToDate.Text);

            var dbData = new UserOperationsContext();
            var events = dbData.Events.ToList();
            ViewState["lstEvent"] = events;

            PopulateGridView(from, to);
        }

        private void PopulateGridView(DateTime from, DateTime to)
        {
            var events = (List<Event>)ViewState["lstEvent"];
            var filteredEvents = events.Where(ev => ev.EventDate >= from && ev.EventDate <= to);
            grdPlannedEvent.DataSource = filteredEvents;
            ViewState["lstEvent"] = filteredEvents.ToList();

            grdPlannedEvent.DataBind();
            for (int i = 0; i < grdPlannedEvent.Rows.Count; i++)
            {
                Button btnAttend = (Button)grdPlannedEvent.Rows[i].FindControl("btnAttendEvent");

                int eventId = (int)grdPlannedEvent.DataKeys[i].Value;
                if (IsUserAttendingThisEvent(eventId))
                {
                    btnAttend.CssClass = "btn btn-success btn-xs";
                    btnAttend.Text = "Stai partecipando";
                }
                else
                {
                    btnAttend.CssClass = "btn btn-info btn-xs";
                    btnAttend.Text = "Partecipa";
                }
            }
        }

        private bool IsUserAttendingThisEvent(int eventId)
        {
            var db = new UserOperationsContext();
            return db.Events.First(a => a.EventId == eventId).RegisteredUsers.Select(u => u.UserName).Contains(_currentUser);
        }

        public List<Event> GetAttendingEvents()
        {
            var dbData = new UserOperationsContext();
            var events = dbData.UsersData.First(u => u.UserName == _currentUser).AttendingEvents;
            return events;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            string id = grdPlannedEvent.DataKeys[rowID].Value.ToString(); 
            Response.Redirect("/MyVale/EventDetails?eventId=" + id);
        }

        protected void btnAttendEvent_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            
            int eventId = (int)grdPlannedEvent.DataKeys[rowID].Value;
            var db = new UserOperationsContext();
            UserData user = db.UsersData.First(u => u.UserName == _currentUser);
            Event thisEvent = db.Events.First(ev => ev.EventId == eventId);
            Button btnAttend = (Button)sender;
            if (!IsUserAttendingThisEvent(eventId))
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
            DateTime from = Convert.ToDateTime(txtFromDate.Text);
            DateTime to = Convert.ToDateTime(txtToDate.Text);
            PopulateGridView(from, to);
        }

        protected void txtFromDate_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtFromDate.Text))
            {
                calendarTo.StartDate = Convert.ToDateTime(txtFromDate.Text).AddDays(7);
                txtToDate.Text = calendarTo.StartDate.Value.ToShortDateString();
            }
        }

        protected void grdPlannedEvent_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;

            if (GridViewSortDirection == SortDirection.Ascending)
                GridViewSortDirection = SortDirection.Descending;
            else
                GridViewSortDirection = SortDirection.Ascending;

            GetSortedData(sortExpression);
        }

        public SortDirection GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] == null)
                    ViewState["sortDirection"] = SortDirection.Ascending;

                return (SortDirection)ViewState["sortDirection"];
            }
            set { ViewState["sortDirection"] = value; }
        }

        private List<Event> GetSortedData(string sortExpression)
        {
            var result = (List<Event>)ViewState["lstEvent"];

            var param = Expression.Parameter(typeof(Event), sortExpression);
            var sortBy = Expression.Lambda<Func<Event, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

            if (GridViewSortDirection == SortDirection.Descending)
                result = result.AsQueryable<Event>().OrderByDescending(sortBy).ToList();
            else
                result = result.AsQueryable<Event>().OrderBy(sortBy).ToList();
            ViewState["lstEvent"] = result;
            PopulateGridView(DateTime.Today, DateTime.Today.AddDays(7));
            return result;
        }
    }
}