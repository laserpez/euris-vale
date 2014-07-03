using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;

namespace VALE.Admin
{
    public partial class EventReport : System.Web.UI.Page
    {
        private int _currentEventId;
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.HasKeys())
                _currentEventId = Convert.ToInt32(Request.QueryString.GetValues("eventId").First());
            _currentUserId = User.Identity.GetUserId();
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
    }
}