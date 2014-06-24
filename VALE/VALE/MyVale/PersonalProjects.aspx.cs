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
            if (!IsPostBack)
            {
                ShowHideControls();
            }
        }

        private void ShowHideControls()
        {
            var db = new UserOperationsContext();
            var organizedPrj = db.UsersData.Where(u => u.UserName == _currentUser).First().OrganizedProjects;
            var attendingPrj = db.UsersData.Where(u => u.UserName == _currentUser).First().AttendingProjects;

            if (organizedPrj.Count() != 0 || attendingPrj.Count() != 0)
            {
                labelSelect.Visible = true;
                btnCurrentView.Visible = true;
            }
            else
            {
                labelSelect.Visible = false;
                btnCurrentView.Visible = false;
            }
        }

        

        public IQueryable<Project> GetPersonalProjects()
        {
            IQueryable<Project> result = null;

            if (btnCurrentView.Attributes.Count != 0)
            {
                var keys = btnCurrentView.Attributes.Keys;

                var aValue = btnCurrentView.Attributes["btnPressed"];
                
                if (!string.IsNullOrEmpty(aValue))
                {
                    if (aValue == "btnAttending")
                        result = GetAttendingProjects();
                    else
                        result = GetOrganizedProjects();
                }
            }
            return result;
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
            var buttonId = button.ID;

            btnCurrentView.InnerText = "Progetti" + " " + button.Text;
            btnCurrentView.Attributes.Remove("btnPressed");
            btnCurrentView.Attributes.Add("btnPressed", buttonId);
            
            grdProjectList.DataBind();

        }
    }
}