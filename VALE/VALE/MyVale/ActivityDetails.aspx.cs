using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class ActivityDetails : System.Web.UI.Page
    {
        private int _currentActivityId;
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            if(Request.QueryString.HasKeys())
                _currentActivityId = Convert.ToInt32(Request.QueryString.GetValues("activityId").First());
        }

        public Activity GetActivity([QueryString("activityId")] int? activityId)
        {
            var db = new UserOperationsContext();
            if (activityId.HasValue)
            {
                _currentActivityId = (int)activityId;
                return db.Activities.Where(a => a.ActivityId == activityId).First();
            }
            else
                return null;
        }

        public IQueryable<UserData> GetUsersInvolved([QueryString("activityId")] int? activityId)
        {
            var db = new UserOperationsContext();
            if (activityId.HasValue)
            {
                var listUsers = db.Reports.Where(r => r.ActivityId == activityId).GroupBy(r => r.Worker).Select(gr => gr.Key);
                return listUsers;
            }
            else
                return null;
        }

        public string GetHoursWorked()
        {
            var db = new UserOperationsContext();
            int hours = db.Reports.Where(r => r.WorkerId == _currentUserId && r.ActivityId == _currentActivityId).Sum(r => r.HoursWorked);
            return String.Format("Hours worked on this activity: {0}", hours);
        }

        public Project GetRelatedProject([QueryString("activityId")] int? activityId)
        {
            var db = new UserOperationsContext();
            var project = db.Projects
                .Where(p => p.ProjectId == db.Activities
                    .Where(a => a.ActivityId == activityId)
                    .Select(a => a.RelatedProject.ProjectId).FirstOrDefault()).FirstOrDefault();
            return project;
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            var btnAddUser = (Button)sender;
            var dbUser = new ApplicationDbContext();
            var dbData = new UserOperationsContext();
            TextBox textBox = (TextBox)ActivityDetail.FindControl("txtUserName");
            string userName = textBox.Text;

            string userId = dbUser.Users.Where(p => p.FirstName + " " + p.LastName == userName).Select(u => u.Id).FirstOrDefault();

            if(!String.IsNullOrEmpty(userId))
            {
                Activity activity = dbData.Activities.Where(a => a.ActivityId == _currentActivityId).First();
                UserData userData = dbData.UsersData.Where(ud => ud.UserDataId == userId).First();
                
                // TODO aggiungere il controllo nel caso l'utente sia già assegnato
                // TODO mandare email di notifica
                userData.PendingActivity.Add(activity);

                dbData.SaveChanges();
                Label statusLabel = (Label)ActivityDetail.FindControl("lblResultSearchUser");
                statusLabel.Text = "User invited";
                btnAddUser.CssClass = "btn btn-success";
            }
            else
            {
                Label statusLabel = (Label)ActivityDetail.FindControl("lblResultSearchUser");
                statusLabel.Text = "This user does not exists";
                btnAddUser.CssClass = "btn btn-warning";
            }

        }

        protected void btnSearchProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            FormView fwProject = (FormView)ActivityDetail.FindControl("ProjectDetail");
            TextBox textBox = (TextBox)fwProject.FindControl("txtProjectName");
            string projectName = textBox.Text;
            Project project = dbData.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if(project != null)
            {
                Activity activity = dbData.Activities.Where(a => a.ActivityId == _currentActivityId).First();
                activity.RelatedProject = project;
                project.Activities.Add(activity);
                dbData.SaveChanges();
            }
            else
            {
                Label statusLabel = (Label)fwProject.FindControl("lblResultAddProject");
                statusLabel.Text = "This project does not exists";
            }
        }

        protected void btnAddReport_Click(object sender, EventArgs e)
        {
            TextBox txtHours = (TextBox)ActivityDetail.FindControl("txtHours");
            TextBox txtDescription = (TextBox)ActivityDetail.FindControl("txtDescription");
            Button btnAdd = (Button)sender;
            Label lblHoursWorked = (Label)ActivityDetail.FindControl("lblHoursWorked");
            var db = new UserOperationsContext();
            int hours = 0;
            if(int.TryParse(txtHours.Text, out hours))
            {
                db.Reports.Add(new ActivityReport
                    {
                        ActivityId = _currentActivityId,
                        WorkerId =_currentUserId,
                        ActivityDescription = txtDescription.Text,
                        Date = DateTime.Today,
                        HoursWorked = hours
                    });
                db.SaveChanges();
                btnAdd.CssClass = "btn btn-success";
                btnAdd.Text = "Report added";
                lblHoursWorked.Text = GetHoursWorked();
            }
            else
            {
                txtHours.Text = "";
                btnAdd.CssClass = "btn btn-danger";
                btnAdd.Text = "Error";
            }

        }

    }
}