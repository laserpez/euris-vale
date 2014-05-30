using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class PersonalEvents : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
        }

        public IQueryable<Event> GetAttendingEvents()
        {
            var db = new UserOperationsContext();
            return db.UsersData.First(u => u.UserDataId == _currentUserId).AttendingEvents.AsQueryable();
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            string id = grdPlannedEvent.Rows[rowID].Cells[0].Text;
            Response.Redirect("/MyVale/EventDetails?eventId=" + id);
        }
    }
}