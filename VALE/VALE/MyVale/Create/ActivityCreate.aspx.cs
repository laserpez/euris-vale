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
        private string _currentUser = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                calendarFrom.StartDate = DateTime.Now;
                calendarTo.StartDate = calendarFrom.StartDate.Value.AddDays(1);
            }
        }

        protected void btnSaveActivity_Click(object sender, EventArgs e)
        {
                var db = new UserOperationsContext();
            var project = db.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text);
            DateTime? expireDate = null;
            if(!String.IsNullOrEmpty(txtEndDate.Text))
                expireDate = Convert.ToDateTime(txtEndDate.Text);
            var newActivity = new Activity
            {
                ActivityName = txtName.Text,
                Description = txtDescription.Text,
                Status = Convert.ToDateTime(txtStartDate.Text) > DateTime.Today ? ActivityStatus.Planned : ActivityStatus.Ongoing,
                StartDate = Convert.ToDateTime(txtStartDate.Text),
                ExpireDate = expireDate,
                RelatedProject = project,
                PendingUsers = new List<UserData>(),
                CreatorUserName = _currentUser
            };
            db.Activities.Add(newActivity);
            db.SaveChanges();
            db.Reports.Add(new ActivityReport
            {
                ActivityId = newActivity.ActivityId,
                WorkerUserName = _currentUser,
                HoursWorked = 0,
                ActivityDescription = "Creazione attività",
                Date = DateTime.Today

            });
            db.SaveChanges();

            Response.Redirect("/MyVale/Activities");
        }

        //protected void btnSearchProject_Click(object sender, EventArgs e)
        //{
        //    var dbData = new UserOperationsContext();
        //    string projectName = txtProjectName.Text;
        //    Project project = dbData.Projects.FirstOrDefault(p => p.ProjectName == projectName);
        //    if (project != null)
        //    {
        //        lblResultSearchProject.Text = String.Format("This activity is now related to project {0}", txtProjectName.Text);
        //        btnSearchProject.CssClass = "btn btn-success";
        //    }
        //    else
        //    {
        //        lblResultSearchProject.Text = "This project does not exist";
        //        btnSearchProject.CssClass = "btn btn-warning";
        //    }
        //}

        protected void txtStartDate_TextChanged(object sender, EventArgs e)
        {
            DateTime startDate;
            if (DateTime.TryParse(txtStartDate.Text, out startDate))
                calendarTo.StartDate = startDate.AddDays(1);
        }
    }
}