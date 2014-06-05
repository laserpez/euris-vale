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
using System.Web.UI.HtmlControls;

namespace VALE.MyVale
{
    public partial class ActivityDetails : System.Web.UI.Page
    {
        private int _currentActivityId;
        private string _currentUser;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUser = User.Identity.GetUserName();
            if(Request.QueryString.HasKeys())
                _currentActivityId = Convert.ToInt32(Request.QueryString["activityId"]);
            
        }

        private LinkButton FindButton(string name)
        {
            return (LinkButton)ActivityDetail.FindControl(name);
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            LinkButton btnOngoing = FindButton("btnOngoing");
            LinkButton btnSuspended = FindButton("btnSuspended");
            HtmlButton btnChangeStatus = (HtmlButton)ActivityDetail.FindControl("btnChangeStatus");
            Label lblInfoChangeStatus = (Label)ActivityDetail.FindControl("lblInfoChangeStatus");
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);

            btnOngoing.Visible = activity.Status == ActivityStatus.Suspended;
            btnSuspended.Visible = activity.Status == ActivityStatus.Ongoing;
            btnChangeStatus.Visible = activity.Status != ActivityStatus.Deleted;
            lblInfoChangeStatus.Visible = activity.Status == ActivityStatus.Deleted;

            
        }

        protected void btnChangeStatus_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string statusString = btn.CommandArgument;
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            ActivityStatus newStatus;
            Enum.TryParse(statusString, out newStatus);
            activity.Status = newStatus;
            _db.SaveChanges();
            ActivityDetail.DataBind();
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
                hours = activityActions.GetHoursWorked(_currentUser, _currentActivityId);
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
            var dbData = new UserOperationsContext();
            TextBox textBox = (TextBox)ActivityDetail.FindControl("txtUserName");
            string userName = textBox.Text;

            var user = dbData.UsersData.FirstOrDefault(p => p.FullName == userName);

            if(user != null)
            {
                Activity activity = dbData.Activities.Where(a => a.ActivityId == _currentActivityId).First();
                
                // TODO aggiungere il controllo nel caso l'utente sia già assegnato
                // TODO mandare email di notifica
                user.PendingActivity.Add(activity);

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
                        WorkerUserName =_currentUser,
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