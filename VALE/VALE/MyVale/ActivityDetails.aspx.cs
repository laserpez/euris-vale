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
using System.Drawing;

namespace VALE.MyVale
{
    public partial class ActivityDetails : Page
    {
        private int _currentActivityId;
        private string _currentUser;
        private UserOperationsContext _db;


        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _currentActivityId = Convert.ToInt32(Request.QueryString["activityId"]);
            if (Request.QueryString["From"] != null)
                Session["ActivityDetailsRequestFrom"] = Request.QueryString["From"];
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
           
        }

        public void PagePermission()
        {
            if (_db.Activities.FirstOrDefault(o => o.ActivityId == _currentActivityId).RegisteredUsers.Where(u => u.UserName == _currentUser).ToList().Count == 0
               && _db.Activities.FirstOrDefault(o => o.ActivityId == _currentActivityId).Creator.UserName != _currentUser)
            {
                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ActivityDetails.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Attivita"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ActivityDetails.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public string GetStatus(Activity anActivity)
        {
            var activityActions = new ActivityActions();
            return activityActions.GetStatus(anActivity);
        }

        
        public string GetStatusColor(ActivityStatus status)
        {
            if (status == ActivityStatus.ToBePlanned)
                return "btn btn-primary dropdown-toggle";
            if (status == ActivityStatus.Suspended)
                return "btn btn-warning dropdown-toggle";
            if (status == ActivityStatus.Ongoing)
                return "btn btn-success dropdown-toggle";
            if (status == ActivityStatus.Done)
                return "btn btn-default dropdown-toggle";
            if (status == ActivityStatus.Deleted)
                return "btn btn-danger dropdown-toggle";
            return "";
        }

        public List<ActivityType> GetTypes()
        {
            var db = new UserOperationsContext();
            return db.ActivityTypes.ToList();
        }

        private LinkButton FindButton(string name)
        {
            return (LinkButton)ActivityDetail.FindControl(name);
        }

        private void SetPersonalInterventionsMode() 
        {
            GridView grdActivityReport = (GridView)ActivityDetail.FindControl("grdActivityReport");
            HtmlButton btnPersonal = (HtmlButton)ActivityDetail.FindControl("btnPersonal");
            HtmlButton btnAllUsers = (HtmlButton)ActivityDetail.FindControl("btnAllUsers");
            Label lblAllOrPersonal = (Label)ActivityDetail.FindControl("lblAllOrPersonal");
            lblAllOrPersonal.Text = "Personal";
            btnPersonal.Visible = true;
            btnAllUsers.Visible = false;
            grdActivityReport.Columns[0].Visible = false;
            grdActivityReport.DataBind();
        }

        private void SetAllInterventionsMode()
        {
            GridView grdActivityReport = (GridView)ActivityDetail.FindControl("grdActivityReport");
            HtmlButton btnPersonal = (HtmlButton)ActivityDetail.FindControl("btnPersonal");
            HtmlButton btnAllUsers = (HtmlButton)ActivityDetail.FindControl("btnAllUsers");
            Label lblAllOrPersonal = (Label)ActivityDetail.FindControl("lblAllOrPersonal");
            lblAllOrPersonal.Text = "All";
            btnPersonal.Visible = false;
            btnAllUsers.Visible = true;
            grdActivityReport.Columns[0].Visible = true;
            grdActivityReport.DataBind();
        }

        private void BlockActivity(string projectStatus) 
        {
            Label lblInfoBlockStatement = (Label)ActivityDetail.FindControl("lblInfoBlockStatement");
            Label lblProjectStatus = (Label)ActivityDetail.FindControl("lblProjectStatus");
            HtmlButton btnStatus = (HtmlButton)ActivityDetail.FindControl("btnStatus");
            Button btnAddReport = (Button)ActivityDetail.FindControl("btnAddReport");
            Button btnInviteUser = (Button)ActivityDetail.FindControl("btnInviteUser");
            Button btnModifyActivity = (Button)ActivityDetail.FindControl("btnModifyActivity");
            Button btnDeleteRelatedProject = (Button)ActivityDetail.FindControl("btnDeleteRelatedProject");
            Button btnAddRelatedProject = (Button)ActivityDetail.FindControl("btnAddRelatedProject");
            btnStatus.Disabled = true;
            btnInviteUser.Visible = false;
            btnModifyActivity.Visible = false;
            btnDeleteRelatedProject.Visible = false;
            btnAddRelatedProject.Visible = false;
            btnAddReport.Visible = false;
            lblInfoBlockStatement.Visible = true;
            lblProjectStatus.Visible = true;
            lblProjectStatus.Text = projectStatus;
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
           
            HtmlButton btnStatus = (HtmlButton)ActivityDetail.FindControl("btnStatus");
            Button btnAddReport = (Button)ActivityDetail.FindControl("btnAddReport");
            Button btnInviteUser = (Button)ActivityDetail.FindControl("btnInviteUser");
            Button btnModifyActivity = (Button)ActivityDetail.FindControl("btnModifyActivity");
            Button btnDeleteRelatedProject = (Button)ActivityDetail.FindControl("btnDeleteRelatedProject");
            Button btnAddRelatedProject = (Button)ActivityDetail.FindControl("btnAddRelatedProject");
            var activity = _db.Activities.Where(a => a.ActivityId == _currentActivityId).FirstOrDefault();
            if (activity.RelatedProject != null && activity.RelatedProject.Status != "Aperto")
                BlockActivity(activity.RelatedProject.Status);
            else
            {
                if (RoleActions.checkPermission(_currentUser, "Amministrazione"))
                {
                    btnStatus.Disabled = false;
                    btnInviteUser.Visible = true;
                    btnAddRelatedProject.Visible = true;

                }
                else if (_currentUser == activity.CreatorUserName)
                {
                    btnStatus.Disabled = false;
                    btnInviteUser.Visible = true;
                    btnModifyActivity.Visible = true;
                }
                else
                {
                    btnStatus.Disabled = true;
                    btnInviteUser.Visible = false;
                    btnModifyActivity.Visible = false;
                    btnDeleteRelatedProject.Visible = false;
                    btnAddRelatedProject.Visible = false;
                }

                if (activity.Status != ActivityStatus.ToBePlanned && activity.Status != ActivityStatus.Ongoing)
                    btnAddReport.Visible = false;

                if (!IsPostBack)
                {
                    if (_currentUser == activity.CreatorUserName)
                        SetAllInterventionsMode();
                    else
                        SetPersonalInterventionsMode();
                }
            }
            
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
            {
                var activity = _db.Activities.FirstOrDefault(a => a.ActivityId == activityId);
                if(activity != null)
                {
                    var users = activity.RegisteredUsers;
                    users.AddRange(activity.PendingUsers);
                    return users.AsQueryable();
                }
            } 
            return null;
        }

        public string GetStatusOfActivityRequest(UserData user) 
        {
            
            var activity = _db.Activities.FirstOrDefault(a => a.ActivityId == _currentActivityId);
            if (activity.PendingUsers.FirstOrDefault(u => u.UserName == user.UserName) != null)
                return "In Attesa";
            return "Acettato";

        }

        public void SetupBugetAndHoursWorked()
        {
            Label lblBudget = (Label)ActivityDetail.FindControl("lblBudget");
            Label lblColorBuget = (Label)ActivityDetail.FindControl("lblColorBuget");
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            var activityActions = new ActivityActions();
            int totalHours = activityActions.GetAllActivityHoursWorked(activity.ActivityId);
            if (activity != null) 
            {
                lblBudget.Text = String.Format(" {0} Erogato {1}", activity.Budget, totalHours);
                if (activity.Budget < totalHours && activity.Budget > 0)
                    lblColorBuget.ForeColor = Color.Red;
                else
                    lblColorBuget.ForeColor = Color.FromArgb(102, 102, 102);
            }            
        }


        protected void btnInviteUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + _currentActivityId + "&dataType=activity&returnUrl=/MyVale/ActivityDetails?activityId=" + _currentActivityId);
        }


        public IQueryable<ActivityReport> grdActivityReport_GetData()
        {
            Label lblAllOrPersonal = (Label)ActivityDetail.FindControl("lblAllOrPersonal");
            Label lblHoursWorked = (Label)ActivityDetail.FindControl("lblHoursWorked");
            var activityId = Convert.ToInt32(_currentActivityId);
            if (lblAllOrPersonal.Text == "Personal")
            {
                var interventions = _db.Reports.Where(r => r.WorkerUserName == _currentUser && r.ActivityId == activityId).OrderByDescending(r => r.ActivityReportId).AsQueryable();
                if (interventions.Count() > 0) 
                {
                    int? hours = interventions.Sum(r => r.HoursWorked);
                    if (hours.HasValue) 
                    {
                        lblHoursWorked.Text = "Totale " + hours.Value + " Ore";
                        SetupBugetAndHoursWorked();
                    }
                }
                
                return interventions;
            }
            else 
            {
                var interventions = _db.Reports.Where(r => r.ActivityId == activityId).OrderByDescending(r => r.WorkerUserName).AsQueryable();
                if (interventions.Count() > 0)
                {
                    int? hours = interventions.Sum(r => r.HoursWorked);
                    if (hours.HasValue)
                    {
                        lblHoursWorked.Text = "Totale " + hours.Value + " Ore";
                        SetupBugetAndHoursWorked();
                    }
                }
                return interventions;
            }
        }

        protected void btnPersonalLinkButton_Click(object sender, EventArgs e)
        {
            SetPersonalInterventionsMode();
        }

        protected void btnAllUsersLinkButton_Click(object sender, EventArgs e)
        {
            SetAllInterventionsMode();
        }

        public bool ModifyInterventionsAcces(ActivityReport report) 
        {
            var db = new UserOperationsContext();
            bool ok = true;
            var activity = db.Activities.Where(a => a.ActivityId == _currentActivityId).FirstOrDefault();
            if (report.WorkerUserName != _currentUser)
                ok = false;
            if (RoleActions.checkPermission(_currentUser, "Amministrazione"))
                ok = true;
            if (activity.Status != ActivityStatus.ToBePlanned && activity.Status != ActivityStatus.Ongoing)
                ok = false;
            if (activity.RelatedProject != null && activity.RelatedProject.Status != "Aperto")
                 ok = false;
            return ok;
        }
       
        protected void btnOkButton_Click(object sender, EventArgs e)
        {
            var action = lblAction.Text;
            GridView grdActivityReport = (GridView)ActivityDetail.FindControl("grdActivityReport");
            Label lblHoursWorked = (Label)ActivityDetail.FindControl("lblHoursWorked");
            if (action == "Add")
            {
                Button btnAdd = (Button)sender;
                int hours = 0;
                if (int.TryParse(txtHours.Text, out hours))
                {
                    _db.Reports.Add(new ActivityReport
                    {
                        ActivityId = _currentActivityId,
                        WorkerUserName = _currentUser,
                        ActivityDescription = txtDescription.Value,
                        Date = DateTime.Today,
                        HoursWorked = hours
                    });

                    var activity = _db.Activities.FirstOrDefault(act => act.ActivityId == _currentActivityId);
                    if (activity.Status == ActivityStatus.ToBePlanned)
                    {
                        activity.Status = ActivityStatus.Ongoing;
                        activity.StartDate = DateTime.Now;
                    }
                    activity.LastModified = DateTime.Today;
                    if (activity.RelatedProject != null)
                    {
                        activity.RelatedProject.LastModified = DateTime.Today;
                        var actions = new ProjectActions();
                        var listHierarchyUp = actions.getHierarchyUp(activity.RelatedProject.ProjectId);
                        if (listHierarchyUp.Count != 0)
                            listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);
                    }

                    _db.SaveChanges();
                    
                    var activityActions = new ActivityActions();
                    activityActions.ComposeMessage(_currentActivityId, "", "Aggiunto intervento");
                }
                grdActivityReport.DataBind();
            }
            else if (action == "Edit")
            {
                var reportId = Convert.ToInt32(lblReportId.Text);
                var report = _db.Reports.FirstOrDefault(r => r.ActivityReportId == reportId);
                if (report != null)
                {
                    report.HoursWorked = Convert.ToInt32(txtHours.Text);
                    report.ActivityDescription = txtDescription.InnerText;
                    _db.SaveChanges();
                }
                grdActivityReport.DataBind();
            }
            else if (action == "Details")
                ModalPopup.Hide();
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + _currentActivityId);
        }
        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void ChangeActivityStatus_Click(object sender, EventArgs e)
        {
            HtmlButton btnStatus = (HtmlButton)ActivityDetail.FindControl("btnStatus");
            var button = (LinkButton)sender;
            string argument = button.CommandArgument;
            ActivityStatus status;
            btnStatus.InnerHtml = GetButtonName(button.Text) + " <span class=\"caret\">";
            switch (argument)
            {
                case "ToBePlanned":
                    status = ActivityStatus.ToBePlanned;
                    break;
                case "Ongoing":
                    status = ActivityStatus.Ongoing;
                    break;
                case "Suspended":
                    status = ActivityStatus.Suspended;
                    break;
                case "Done":
                    status = ActivityStatus.Done;
                    break;
                default:
                    status = ActivityStatus.ToBePlanned;
                    break;
            }
            var activityActions = new ActivityActions();
            activityActions.SetActivityStatus(_currentActivityId, status);
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + _currentActivityId);
            //ActivityDetail.DataBind();
        }
        private string GetButtonName(string html)
        {
            string[] lineTokens = html.Split('>');
            return lineTokens[2].Trim();
        }

        protected void grdActivityReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "ShowReport":
                    ShowReport(Convert.ToInt32(e.CommandArgument));
                    break;
                case "EditReport":
                    EditReport(Convert.ToInt32(e.CommandArgument));
                    break;
                case "DeleteReport":
                    DeleteReport(Convert.ToInt32(e.CommandArgument));
                    break;
                case "Page":
                    break;
            }
        }

        protected void btnAddReport_Click(object sender, EventArgs e)
        {
            btnOkGroupButton.Text = "Aggiungi";
            btnClosePopUpButton.Visible = true;
            txtHours.Enabled = true;
            txtHours.CssClass = "form-control input-sm";
            txtDescription.Disabled = false;
            txtDescription.Value = "";
            txtHours.Text = "";
            lblAction.Text = "Add";
            ModalPopup.Show();
        }

        private void DeleteReport(int reportId)
        {
            var report = _db.Reports.FirstOrDefault(r => r.ActivityReportId == reportId);
            if (report != null)
            {
                _db.Reports.Remove(report);

                var activity = _db.Activities.FirstOrDefault(act => act.ActivityId == _currentActivityId);
                activity.LastModified = DateTime.Today;
                if (activity.RelatedProject != null)
                {
                    activity.RelatedProject.LastModified = DateTime.Today;
                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(activity.RelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);
                }

                _db.SaveChanges();
                GridView grdActivityReport = (GridView)ActivityDetail.FindControl("grdActivityReport");
                grdActivityReport.PageIndex = 0;
                grdActivityReport.DataBind();
                Response.Redirect("/MyVale/ActivityDetails?activityId=" + _currentActivityId);
            }
        }

        private void EditReport(int reportId)
        {
            var report = _db.Reports.FirstOrDefault(r => r.ActivityReportId == reportId);
            if (report != null)
            {
                btnClosePopUpButton.Visible = true;
                btnOkGroupButton.Text = "Salva";
                txtHours.Enabled = true;
                txtHours.CssClass = "form-control input-sm";
                txtDescription.Disabled = false;
                txtHours.Text = report.HoursWorked.ToString();
                txtDescription.InnerText = report.ActivityDescription;
                lblAction.Text = "Edit";
                lblReportId.Text = reportId.ToString();
                ModalPopup.Show();
            }
        }

        private void ShowReport(int reportId)
        {
            var report = _db.Reports.FirstOrDefault(r => r.ActivityReportId == reportId);
            if (report != null)
            {
                btnClosePopUpButton.Visible = false;
                btnOkGroupButton.Text = "Chiudi";
                txtHours.Enabled = false;
                txtHours.CssClass = "form-control input-sm disabled";
                txtDescription.Disabled = true;
                txtHours.Text = report.HoursWorked.ToString();
                txtDescription.InnerText = report.ActivityDescription;
                lblAction.Text = "Details";
                ModalPopup.Show();
            }
        }

        protected void btnModifyActivity_Click(object sender, EventArgs e)
        {
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            txtName.Text = activity.ActivityName;
            txtActDescription.Text = activity.Description;
            txtBudget.Text = activity.Budget.ToString();
            txtStartDate.Text = activity.StartDate.HasValue ? activity.StartDate.Value.ToShortDateString() : "";
            txtEndDate.Text = activity.ExpireDate.HasValue ? activity.ExpireDate.Value.ToShortDateString() : "";
            ddlSelectType.SelectedValue = activity.Type;
            ModalPopupActivity.Show();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void btnConfirmModify_Click(object sender, EventArgs e)
        {
            int budget = 0;
            int.TryParse(txtBudget.Text, out budget);
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            activity.ActivityName = txtName.Text;
            activity.Budget = budget;
            activity.Description = txtActDescription.Text;
            DateTime? expireDate = null;
            if (!String.IsNullOrEmpty(txtEndDate.Text))
                expireDate = Convert.ToDateTime(txtEndDate.Text);
            DateTime? startDate = null;
            if (!String.IsNullOrEmpty(txtStartDate.Text))
                startDate = Convert.ToDateTime(txtStartDate.Text);
            activity.StartDate = startDate;
            activity.ExpireDate = expireDate;
            activity.Type = ddlSelectType.SelectedValue;
            activity.LastModified = DateTime.Today;
            if (activity.RelatedProject != null)
            {
                activity.RelatedProject.LastModified = DateTime.Today;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(activity.RelatedProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);
            }

            _db.SaveChanges();

            Response.Redirect("/MyVale/ActivityDetails?activityId=" + _currentActivityId);
            ModalPopup.Hide();
        }


        //++++++++++++++++++++++++++RelatedProject+++++++++++++++++++++++++++++++++
        protected void btnDeleteRelatedProject_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Hide();
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            activity.LastModified = DateTime.Today;
            var projectRelated = _db.Projects.FirstOrDefault(p => p.ProjectId == activity.ProjectId);
            projectRelated.Activities.Remove(activity);

            projectRelated.LastModified = DateTime.Today;
            var actions = new ProjectActions();
            var listHierarchyUp = actions.getHierarchyUp(projectRelated.ProjectId);
            if (listHierarchyUp.Count != 0)
                listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);

            _db.SaveChanges();

            var activityActions = new ActivityActions();
            activityActions.ComposeMessage(_currentActivityId, "", "Rimozione progetto correlato");

            GridView grdRelatedProject = (GridView)ActivityDetail.FindControl("grdRelatedProject");
            grdRelatedProject.DataBind();
        }

        protected void btnAddRelatedProject_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Show();
        }

        public IQueryable<Project> GetProjects()
        {
            var _db = new UserOperationsContext();
            return _db.Projects.Where(pr => pr.Status != "Chiuso").OrderBy(p => p.ProjectName);
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Hide();
        }

        protected void btnChooseProject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            var project = _db.Projects.FirstOrDefault(p=>p.ProjectName == btn.CommandArgument);
            if(project != null)
            {
                var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
                activity.RelatedProject = project;
                activity.LastModified = DateTime.Today;
                project.LastModified = DateTime.Today;
                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(activity.RelatedProject.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Today);

                _db.SaveChanges();
                var activityActions = new ActivityActions();
                activityActions.ComposeMessage(_currentActivityId, "", "Aggiunto progetto correlato");

                GridView grdRelatedProject = (GridView)ActivityDetail.FindControl("grdRelatedProject");
                grdRelatedProject.DataBind();
                Response.Redirect("/MyVale/ActivityDetails?activityId=" + _currentActivityId);
            }
        }

        //Devono essere gestiti i vincoli per la modifica : amministratore/utente normale/creatore dell'attività
        public IQueryable<Project> GetRelatedProject([QueryString("activityId")] int? activityId)
        {
            ModalPopupListProject.Hide();
            if (activityId.HasValue)
            {
                Button btnModifyRelatedProject = (Button)ActivityDetail.FindControl("btnModifyRelatedProject");
                Button btnDeleteRelatedProject = (Button)ActivityDetail.FindControl("btnDeleteRelatedProject");
                Button btnAddRelatedProject = (Button)ActivityDetail.FindControl("btnAddRelatedProject");
                var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
                var project = activity.RelatedProject;
                if (project != null)
                {
                    btnDeleteRelatedProject.Visible = true;
                    btnAddRelatedProject.Visible = false;
                    var list = new List<Project> { project };
                    return list.AsQueryable();
                }
                else
                {
                    btnDeleteRelatedProject.Visible = false;
                    btnAddRelatedProject.Visible = true;
                }
            }
            return null;
        }

        protected void ActivityDetail_DataBound(object sender, EventArgs e)
        {
            if (_currentActivityId != 0)
            {
                string result = _db.Activities.FirstOrDefault(ac => ac.ActivityId == _currentActivityId).Description;
                Label lblContent = (Label)ActivityDetail.FindControl("lblContent");
                lblContent.Text = result;
            }
        }

        public string GetDescription(string description)
        {
            if (!String.IsNullOrEmpty(description))
            {
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(description);
                description = doc.DocumentNode.InnerText;
                return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
            }
            else
            {
                return "Nessuna descrizione presente";
            }
        }

        protected void btnBack_ServerClick(object sender, EventArgs e)
        {
            string returnUrl = "";
            if (Session["ActivityDetailsRequestFrom"] != null)
                returnUrl = Session["ActivityDetailsRequestFrom"].ToString();
            else
                returnUrl = "/MyVale/Activities";
            Session["ActivityDetailsRequestFrom"] = null;
            Response.Redirect(returnUrl);
        }

        public bool ModifyToBePlannedStatusAcces() 
        {
            var interventions = _db.Reports.Where(r => r.ActivityId == _currentActivityId).OrderByDescending(r => r.WorkerUserName);
            if (interventions.Count() > 0)
                return false;
            return true;
        }
    }
}