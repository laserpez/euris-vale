using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE
{
    public partial class _Default : Page
    {
        private UserData _currentUser;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            notLoggedUser.Visible = !HttpContext.Current.User.Identity.IsAuthenticated;
            loggedUser.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
            _currentUser = _db.UserDatas.FirstOrDefault(u => u.UserName == User.Identity.Name);
        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string uri = String.Format("/MyVale/{0}.aspx", btn.CommandArgument);
            Response.Redirect(uri);

        }

        public IQueryable<Project> GetProjects()
        {
            if (_currentUser != null)
                return _currentUser.AttendingProjects.Take(10).AsQueryable();
            else
                return null;
        }

        public IQueryable<Event> GetEvents()
        {
            if (_currentUser != null)
                return _currentUser.AttendingEvents.Take(10).AsQueryable();
            else
                return null;
        }

        public IQueryable<Activity> GetActivities()
        {
            var actions = new ActivityActions();
            if (_currentUser != null)
                return actions.GetActivities(_currentUser.UserName, ActivityStatus.Ongoing).AsQueryable();
            else
                return null;
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string uri = String.Format("/MyVale/{0}", btn.CommandArgument);
            Response.Redirect(uri);
        }

       

        
        
    }
}