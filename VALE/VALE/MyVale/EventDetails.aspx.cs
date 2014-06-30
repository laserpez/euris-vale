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
using VALE.MyVale.Create;

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
            FileUploader uploader = (FileUploader)EventDetail.FindControl("FileUploader");
            uploader.DataActions = new EventActions();
            uploader.DataId = _currentEventId;
            if(!IsPostBack)
                uploader.DataBind();

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            Button btnAttend = (Button)EventDetail.FindControl("btnAttend");
            var eventActions = new EventActions();
            if(eventActions.IsUserRelated(_currentEventId, _currentUser))
            {
                btnAttend.CssClass = "btn btn-success";
                btnAttend.Text = "Stai partecipando";
            }
            else
            {
                btnAttend.CssClass = "btn btn-info";
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
                return _db.Events.Where(e => e.EventId == eventId).FirstOrDefault().RegisteredUsers.AsQueryable();
            else
                return null;
        }

        public Project GetRelatedProject([QueryString("eventId")] int? eventId)
        {
            var project = _db.Events.First(e => e.EventId == eventId).RelatedProject;
            return project;
        }

        protected void btnAttend_Click(object sender, EventArgs e)
        {
            UserData user = _db.UsersData.First(u => u.UserName == _currentUser);
            Event thisEvent = _db.Events.First(ev => ev.EventId == _currentEventId);
            Button btnAttend = (Button)EventDetail.FindControl("btnAttend");
            var eventActions = new EventActions();
            if (eventActions.AddOrRemoveUserData(thisEvent, user) == true)
            {
                // MAIL
                //string eventToString = String.Format("{0}\nCreated by:{1}\nDate:{2}\n\n{3}", thisEvent.Name, thisEvent.Organizer.FullName, thisEvent.EventDate, thisEvent.Description);
                //MailHelper.SendMail(user.Email, String.Format("You succesfully registered to event:\n{0}", eventToString), "Event notification");
                //MailHelper.SendMail(user.Email, String.Format("User {0} is now registered to your event:\n{1}", user.FullName, eventToString), "Event notification");
            }
            _db.SaveChanges();
            Response.Redirect("/MyVale/EventDetails.aspx?eventId=" + _currentEventId);
        }
    }
}