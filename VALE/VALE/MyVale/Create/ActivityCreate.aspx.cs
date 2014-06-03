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
    public partial class ActivityCreate : System.Web.UI.Page
    {
        private string _currentUserId = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            if (!IsPostBack)
            {
                calendarFrom.StartDate = DateTime.Now;
                calendarTo.StartDate = calendarFrom.StartDate.Value.AddDays(1);
            }
        }

        protected void btnSaveActivity_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var project = db.Projects.FirstOrDefault(p => p.ProjectName == txtProjectName.Text);
            var newActivity = new Activity
            {
                ActivityName = txtName.Text,
                Description = txtDescription.Text,
                Status = "ongoing",
                CreationDate = Convert.ToDateTime(txtStartDate.Text),
                ExpireDate = String.IsNullOrEmpty(txtEndDate.Text) ? DateTime.MaxValue : Convert.ToDateTime(txtEndDate.Text),
                RelatedProject = project,
                PendingUsers = new List<UserData>(),
                UserDataId = _currentUserId
            };
            db.Activities.Add(newActivity);
            db.SaveChanges();
            db.Reports.Add(new ActivityReport
            {
                ActivityId = newActivity.ActivityId,
                WorkerId = _currentUserId,
                HoursWorked = 0,
                ActivityDescription = "Creazione attività",
                Date = DateTime.Today

            });
            db.SaveChanges();

            Response.Redirect("/MyVale/Activities");
        }

        protected void btnSearchProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            string projectName = txtProjectName.Text;
            Project project = dbData.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if (project != null)
            {
                lblResultSearchProject.Text = String.Format("This activity is now related to project {0}", txtProjectName.Text);
                btnSearchProject.CssClass = "btn btn-success";
            }
            else
            {
                lblResultSearchProject.Text = "This project does not exist";
                btnSearchProject.CssClass = "btn btn-warning";
            }
        }

        protected void txtStartDate_TextChanged(object sender, EventArgs e)
        {
            calendarTo.StartDate = Convert.ToDateTime(txtStartDate.Text).AddDays(1);
        }
    }
}