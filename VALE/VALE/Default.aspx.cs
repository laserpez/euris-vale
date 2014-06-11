using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE
{
    public partial class _Default : Page
    {
        private UserData _currentUser;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            notLoggedUser.Visible = !HttpContext.Current.User.Identity.IsAuthenticated;
            loggedUser.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
            _currentUser = _db.UsersData.First(u => u.UserName == User.Identity.Name);
        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {

        }

        public IQueryable<Project> GetProjects()
        {
            return _currentUser.AttendingProjects.Take(10).AsQueryable();
        }

        public IQueryable<Event> GetEvents()
        {
            return null;
        }

        public IQueryable<Activity> GetActivities()
        {
            return null;
        }

        protected void btnViewProjectDetails_Click(object sender, EventArgs e)
        {

        }
        
    }
}