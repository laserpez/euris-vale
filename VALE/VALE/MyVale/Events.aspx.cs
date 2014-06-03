using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class Events : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            if (!IsPostBack)
            {
                PopulateGridView(DateTime.Today, DateTime.Today.AddDays(7));
                txtFromDate.Text = DateTime.Today.ToShortDateString();
                txtToDate.Text = DateTime.Today.AddDays(7).ToShortDateString();
                calendarFrom.StartDate = DateTime.Now;
                calendarTo.StartDate = calendarFrom.StartDate.Value.AddDays(1);
                txtToDate.Text = calendarTo.StartDate.Value.ToShortDateString();
            }
        }

        protected void btnShowEvents_Click(object sender, EventArgs e)
        {
            DateTime from = Convert.ToDateTime(txtFromDate.Text);
            DateTime to = Convert.ToDateTime(txtToDate.Text);
            PopulateGridView(from, to);
        }

        private void PopulateGridView(DateTime from, DateTime to)
        {
            var dbData = new UserOperationsContext();
            var events = dbData.Events.Where(ev => ev.EventDate >= from && ev.EventDate <= to);
            grdPlannedEvent.DataSource = events.ToList();
            grdPlannedEvent.DataBind();
            for (int i = 0; i < grdPlannedEvent.Rows.Count; i++)
            {
                Button btnAttend = (Button)grdPlannedEvent.Rows[i].FindControl("btnAttendEvent");
                int eventId = Convert.ToInt32(grdPlannedEvent.Rows[i].Cells[0].Text);
                if (IsUserAttendingThisEvent(eventId))
                {
                    btnAttend.CssClass = "btn btn-success";
                    btnAttend.Text = "Already attending";
                }
                else
                {
                    btnAttend.CssClass = "btn btn-info";
                    btnAttend.Text = "Attend this event";
                }
            }
        }

        private bool IsUserAttendingThisEvent(int eventId)
        {
            var db = new UserOperationsContext();
            return db.Events.First(a => a.EventId == eventId).RegisteredUsers.Select(u => u.UserDataId).Contains(_currentUserId);
        }

        public List<Event> GetAttendingEvents()
        {
            var dbData = new UserOperationsContext();
            var events = dbData.UsersData.First(u => u.UserDataId == _currentUserId).AttendingEvents;
            return events;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            string id = grdPlannedEvent.Rows[rowID].Cells[0].Text;
            Response.Redirect("/MyVale/EventDetails?eventId=" + id);
        }

        protected void btnAttendEvent_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            int eventId = Convert.ToInt32(grdPlannedEvent.Rows[rowID].Cells[0].Text);
            var db = new UserOperationsContext();
            UserData user = db.UsersData.First(u => u.UserDataId == _currentUserId);
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
            calendarTo.StartDate = Convert.ToDateTime(txtFromDate.Text).AddDays(1);
            txtToDate.Text = calendarTo.StartDate.Value.ToShortDateString();
        }

    }
}