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
                txtFromDate.Text = DateTime.Today.ToShortDateString();
                txtToDate.Text = DateTime.Today.AddDays(7).ToShortDateString();

                var dbData = new UserOperationsContext();
                ViewState["lstEvent"] = dbData.Events.ToList();

                FilterEvents();
                UpdateGridView();
            }
        }

        private void UpdateGridView()
        {
            grdPlannedEvent.DataSource = ViewState["lstEvent"];
            grdPlannedEvent.DataBind();

            for (int i = 0; i < grdPlannedEvent.Rows.Count; i++)
            {
                Button btnAttend = (Button)grdPlannedEvent.Rows[i].FindControl("btnAttendEvent");

                int eventId = (int)grdPlannedEvent.DataKeys[i].Value;
                var eventActions = new EventActions();
                if (eventActions.IsUserRelated(eventId, _currentUser))
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

        public void FilterEvents()
        {
            var events = (List<Event>)ViewState["lstEvent"];
            
            using (var eventActions = new EventActions())
            {
                var filters = new Dictionary<string, string>();
                filters.Add("fromDate", txtFromDate.Text);
                filters.Add("toDate", txtToDate.Text);

                ViewState["lstEvent"] = eventActions.GetFilteredData(filters, events);
            }
        }

        protected void btnShowEvents_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            ViewState["lstEvent"] = dbData.Events.ToList();

            FilterEvents();
            UpdateGridView();
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

            var eventActions = new EventActions();
            if(eventActions.AddOrRemoveUserData(thisEvent, user) == true)
            {
                    // MAIL
                    //string eventToString = String.Format("{0}\nCreated by:{1}\nDate:{2}\n\n{3}", thisEvent.Name, thisEvent.Organizer.FullName, thisEvent.EventDate, thisEvent.Description);
                    //MailHelper.SendMail(user.Email, String.Format("You succesfully registered to event:\n{0}", eventToString), "Event notification");
                    //MailHelper.SendMail(user.Email, String.Format("User {0} is now registered to your event:\n{1}", user.FullName, eventToString), "Event notification");
            }
            db.SaveChanges();

            FilterEvents();
            UpdateGridView();
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

            using (var eventActions = new EventActions())
            {
                var events = (List<Event>)ViewState["lstEvent"];
                ViewState["lstEvent"] = eventActions.GetSortedData(sortExpression, GridViewSortDirection, events);
                UpdateGridView();
            }
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

        //private List<Event> GetSortedData(string sortExpression)
        //{
        //    var result = (List<Event>)ViewState["lstEvent"];

        //    var param = Expression.Parameter(typeof(Event), sortExpression);
        //    var sortBy = Expression.Lambda<Func<Event, object>>(Expression.Convert(Expression.Property(param, sortExpression), typeof(object)), param);

        //    if (GridViewSortDirection == SortDirection.Descending)
        //        result = result.AsQueryable<Event>().OrderByDescending(sortBy).ToList();
        //    else
        //        result = result.AsQueryable<Event>().OrderBy(sortBy).ToList();
        //    ViewState["lstEvent"] = result;
        //    PopulateGridView(DateTime.Today, DateTime.Today.AddDays(7));
        //    return result;
        //}
    }
}