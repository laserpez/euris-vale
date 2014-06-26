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
using VALE.MyVale.Create;

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

        public string GetStatus(Activity anActivity)
        {
            if (anActivity.Status == ActivityStatus.ToBePlanned)
                return "Da pianificare";
            if (anActivity.Status == ActivityStatus.Suspended)
                return "Sospesa";
            if (anActivity.Status == ActivityStatus.Ongoing)
                return "In corso";
            if (anActivity.Status == ActivityStatus.Done)
                return "Terminata";
            if (anActivity.Status == ActivityStatus.Deleted)
                return "Cancellata";

            return null;
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

            //btnOngoing.Visible = activity.Status == ActivityStatus.Suspended;
            //btnSuspended.Visible = activity.Status == ActivityStatus.Ongoing;
            //btnChangeStatus.Visible = activity.Status != ActivityStatus.Deleted;
            //lblInfoChangeStatus.Visible = activity.Status == ActivityStatus.Deleted;

            
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
            return String.Format("Ore lavorate su quest'attività: {0}", hours);
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
            //TextBox textBox = (TextBox)ActivityDetail.FindControl("txtUserName");
            //string userName = textBox.Text;

            var userControl = (SelectUser)ActivityDetail.FindControl("SelectUser");
            var users = dbData.UsersData.Where(u => userControl.SelectedUsers.Contains(u.UserName)).ToList();

            foreach (var user in users)
            {
                if (user != null)
                {
                    Activity activity = dbData.Activities.Where(a => a.ActivityId == _currentActivityId).First();

                    if (user.PendingActivity.Contains(activity) == true)
                    {
                        Label statusLabel = (Label)ActivityDetail.FindControl("lblResultSearchUser");
                        statusLabel.Text = "L'attività è già stata invitata all'utente: " + user.UserName;
                        btnAddUser.CssClass = "btn btn-warning btn-xs";
                    }
                    else
                    {
                        MailHelper.SendMail(user.Email, "Sei stato invitato all'attività " + activity.ActivityName, "Invio attività");
                        user.PendingActivity.Add(activity);

                        dbData.SaveChanges();
                        Label statusLabel = (Label)ActivityDetail.FindControl("lblResultSearchUser");
                        statusLabel.Text = "Richiesta inviata agli utenti invitati.";
                        btnAddUser.CssClass = "btn btn-success btn-xs";
                    }
                }
                else
                {
                    Label statusLabel = (Label)ActivityDetail.FindControl("lblResultSearchUser");
                    statusLabel.Text = "L'utente non esiste.";
                    btnAddUser.CssClass = "btn btn-warning btn-xs";
                }
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
                statusLabel.Text = "Il progetto non esiste.";
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
                btnAdd.CssClass = "btn btn-success btn-xs";
                btnAdd.Text = "Report aggiunto";
                lblHoursWorked.Text = GetHoursWorked();
            }
            else
            {
                txtHours.Text = "";
                btnAdd.CssClass = "btn btn-danger btn-xs";
                btnAdd.Text = "Error";
            }

        }

    }
}