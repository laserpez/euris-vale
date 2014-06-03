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
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<Project> GetOrganizedProjects()
        {
            var db = new UserOperationsContext();
            string currentIdUser = User.Identity.GetUserId();
            return db.UsersData.Where(u => u.UserDataId == currentIdUser).First().OrganizedProjects.AsQueryable();
        }

        public IQueryable<Project> GetAttendingProjects()
        {
            var db = new UserOperationsContext();
            string currentIdUser = User.Identity.GetUserId();
            return db.UsersData.Where(u => u.UserDataId == currentIdUser).First().AttendingProjects.AsQueryable();
        }

        protected void grid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            int index = Convert.ToInt32(e.CommandArgument);
            int projectId = Convert.ToInt32(grid.Rows[index].Cells[0].Text);
            Response.Redirect("/MyVale/ProjectDetails?projectId=" + projectId);
        }

        
    }
}