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
    public partial class ActivityDetails : Page
    {
        private int _currentActivityId;
        private string _currentUser;
        private UserOperationsContext _db;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _db = new UserOperationsContext();
            _currentUser = User.Identity.GetUserName();
            if(Request.QueryString.HasKeys())
                _currentActivityId = Convert.ToInt32(Request.QueryString["activityId"]);
            if (Request.QueryString["From"] != null)
                Session["ActivityDetailsRequestFrom"] = Request.QueryString["From"];
        }

        public void PagePermission()
        {
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

        protected void Page_PreRender(object sender, EventArgs e)
        {
            
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
                return _db.Activities.FirstOrDefault(r => r.ActivityId == activityId).PendingUsers.AsQueryable();
            else
                return null;
        }

        public string GetHoursWorked()
        {
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            var activityActions = new ActivityActions();
            int totalHours = activityActions.GetAllActivityHoursWorked(activity.ActivityId);
            if (activity != null)
                if (activity.Budget > 0)
                    return String.Format("Budget Totale: {0} Erogato {1}", activity.Budget, totalHours);
            return String.Format(" {0} Ore di lavoro", totalHours);
        }

        

        protected void btnInviteUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + _currentActivityId + "&dataType=activity&canRemove=false&returnUrl=/MyVale/ActivityDetails?activityId=" + _currentActivityId);
        }


        public IQueryable<ActivityReport> grdActivityReport_GetData()
        {
            var activityId = Convert.ToInt32(_currentActivityId);
            return _db.Reports.Where(r => r.WorkerUserName == _currentUser && r.ActivityId == activityId).OrderByDescending(r => r.ActivityReportId).AsQueryable();
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
                    lblHoursWorked.Text = GetHoursWorked();
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
                lblHoursWorked.Text = GetHoursWorked();
                grdActivityReport.DataBind();
            }
            else if (action == "Details")
                ModalPopup.Hide();

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
            ActivityDetail.DataBind();
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
                grdActivityReport.DataBind();
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

        //Devono essere gestiti i vincoli per la modifica : amministratore/utente normale/creatore dell'attività
    }
}