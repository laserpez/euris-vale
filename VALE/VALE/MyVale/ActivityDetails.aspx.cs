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
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUserId = User.Identity.GetUserId();
            if(Request.QueryString.HasKeys())
                _currentActivityId = Convert.ToInt32(Request.QueryString["activityId"]);
        }

        public Activity GetActivity([QueryString("activityId")] int? activityId)
        {
            if (activityId.HasValue)
                return _db.Activities.Where(a => a.ActivityId == activityId).First();
            else
                return null;
        }

        public IQueryable<UserData> GetUsersInvolved([QueryString("activityId")] int? activityId)
        {
            if (activityId.HasValue)
                return _db.Reports.Where(r => r.ActivityId == activityId).GroupBy(r => r.Worker).Select(gr => gr.Key);
            else
                return null;
        }

        public string GetHoursWorked()
        {
            int hours;
            using (var activityActions = new ActivityActions())
            {
                hours = activityActions.GetHoursWorked(_currentUserId, _currentActivityId);
            }
            return String.Format("Hours worked on this activity: {0}", hours);
        }

        public Project GetRelatedProject([QueryString("activityId")] int? activityId)
        {
            var project = _db.Activities.First(a => a.ActivityId == activityId).RelatedProject;
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
            FormView fwProject = (FormView)ActivityDetail.FindControl("ProjectDetail");
            TextBox textBox = (TextBox)fwProject.FindControl("txtProjectName");
            string projectName = textBox.Text;
            Project project = _db.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if(project != null)
            {
                Activity activity = _db.Activities.Where(a => a.ActivityId == _currentActivityId).First();
                activity.RelatedProject = project;
                project.Activities.Add(activity);
                _db.SaveChanges();
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
            int hours = 0;
            if(int.TryParse(txtHours.Text, out hours))
            {
                _db.Reports.Add(new ActivityReport
                    {
                        ActivityId = _currentActivityId,
                        WorkerId =_currentUserId,
                        ActivityDescription = txtDescription.Text,
                        Date = DateTime.Today,
                        HoursWorked = hours
                    });
                _db.SaveChanges();
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