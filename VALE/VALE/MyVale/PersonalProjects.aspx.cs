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
    public partial class PersonalProjects : System.Web.UI.Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
        }

        public IQueryable<Project> GetPersonalProjects()
        {
            if (btnCurrentView.InnerText == "Attending")
                return GetAttendingProjects();
            else
                return GetOrganizedProjects();
        }

        public IQueryable<Project> GetOrganizedProjects()
        {
            var db = new UserOperationsContext();
            return db.UsersData.Where(u => u.UserName == _currentUser).First().OrganizedProjects.AsQueryable();
        }

        public IQueryable<Project> GetAttendingProjects()
        {
            var db = new UserOperationsContext();
            return db.UsersData.Where(u => u.UserName == _currentUser).First().AttendingProjects.AsQueryable();
        }

        protected void grid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch(e.CommandName)
            {
                case "ViewDetails":
                    int projectId = Convert.ToInt32(e.CommandArgument);
                    Response.Redirect("/MyVale/ProjectDetails?projectId=" + projectId);
                    break;
                default:
                    break;
            }
        }

        protected void btnViewProjects_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            btnCurrentView.InnerText = button.Text;
            grdProjectList.DataBind();

        }
    }
}