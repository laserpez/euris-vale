﻿using System;
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
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
        }

        public IQueryable<Event> GetAttendingEvents()
        {
            var db = new UserOperationsContext();
            return db.UserDatas.First(u => u.UserName == _currentUser).AttendingEvents.AsQueryable();
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            int rowID = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            int eventId = (int)grdPlannedEvent.DataKeys[rowID].Value;
            Response.Redirect("/MyVale/EventDetails?eventId=" + eventId);
        }
    }
}