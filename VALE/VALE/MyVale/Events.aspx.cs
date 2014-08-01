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
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Eventi"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina Events.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
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
            Button btnAttend = (Button)sender;

            var eventActions = new EventActions();
            if(eventActions.AddOrRemoveUserData(eventId, _currentUserName) == true)
            {
                    // MAIL
                    //string eventToString = String.Format("{0}\nCreated by:{1}\nDate:{2}\n\n{3}", thisEvent.Name, thisEvent.Organizer.FullName, thisEvent.EventDate, thisEvent.Description);
                    //MailHelper.SendMail(user.Email, String.Format("You succesfully registered to event:\n{0}", eventToString), "Event notification");
                    //MailHelper.SendMail(user.Email, String.Format("User {0} is now registered to your event:\n{1}", user.FullName, eventToString), "Event notification");
            }
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

        private void ChangeCalendars()
        {
            if (txtFromDate.Text != "" && CheckDate())
            {
                calendarTo.StartDate = Convert.ToDateTime(txtFromDate.Text);
            }
            if (txtFromDate.Text == "")
            {
                txtToDate.Text = "";
            }
        }

        private bool CheckDate()
        {
            if (!String.IsNullOrEmpty(txtToDate.Text))
            {
                var startDate = Convert.ToDateTime(txtFromDate.Text);
                var endDate = Convert.ToDateTime(txtToDate.Text);
                if (startDate > endDate)
                {
                    txtToDate.Text = "";
                    calendarTo.StartDate = Convert.ToDateTime(txtFromDate.Text);
                    return false;
                }
            }
            return true;
        }

        protected void btnShowFilters_Click(object sender, EventArgs e)
        {
            if (filterPanel.Visible)
            {
                filterPanel.Visible = false;
                btnFilterEvents.Visible = false;
                btnClearFilters.Visible = false;
            }
            else
            {
                filterPanel.Visible = true;
                btnFilterEvents.Visible = true;
                btnClearFilters.Visible = true;
            }
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
            return GetFilteredData();
        }

        private IQueryable<Event> GetFilteredData()
        {
            var eventActions = new EventActions();
            var fromDateTxt = "";
            if(!string.IsNullOrEmpty(txtFromDate.Text))
                fromDateTxt = txtFromDate.Text;
            else
                fromDateTxt = DateTime.MinValue.ToShortDateString();
            var toDateTxt = "";
            if(!string.IsNullOrEmpty(txtToDate.Text))
                toDateTxt = txtToDate.Text;
            else
                toDateTxt = DateTime.MaxValue.ToShortDateString();
            var filters = new Dictionary<string, string>();
            filters.Add("fromDate", fromDateTxt);
            filters.Add("toDate", toDateTxt);
            var db = new UserOperationsContext();
            var events = db.Events.ToList();
            return eventActions.GetFilteredData(filters, events).AsQueryable();
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
    }
}