﻿using System;
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
                return _db.Reports.Where(r => r.ActivityId == activityId).GroupBy(r => r.Worker).Select(gr => gr.Key);
            else
                return null;
        }

        public string GetHoursWorked()
        {
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            int hours;
            var activityActions = new ActivityActions();
            hours = activityActions.GetHoursWorked(_currentUser, _currentActivityId);
          
            if (activity != null)
                if (activity.Budget > 0) 
                    return String.Format("Budget Totale: {0} Erogato {1}", activity.Budget, hours);
           return String.Format(" {0} Ore di lavoro", hours);
        }

        

        protected void btnInviteUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + _currentActivityId + "&dataType=activity&canRemove=false&returnUrl=/MyVale/ActivityDetails?activityId=" + _currentActivityId);
        }


        public IQueryable<VALE.Models.ActivityReport> grdActivityReport_GetData()
        {
            var activityId = Convert.ToInt32(_currentActivityId);
            return _db.Reports.Where(r => r.WorkerUserName == _currentUser && r.ActivityId == activityId).OrderByDescending(r => r.ActivityReportId).AsQueryable();
        }

       

        protected void btnOkButton_Click(object sender, EventArgs e)
        {
            var action = lblAction.Text;
            if (action == "Add")
            {
                GridView grdActivityReport = (GridView)ActivityDetail.FindControl("grdActivityReport");
                Button btnAdd = (Button)sender;
                Label lblHoursWorked = (Label)ActivityDetail.FindControl("lblHoursWorked");
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
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            activity.ActivityName = txtName.Text;
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
            _db.SaveChanges();
            Response.Redirect("/MyVale/ActivityDetails?activityId=" + _currentActivityId);
            ModalPopup.Hide();
        }


        //++++++++++++++++++++++++++RelatedProject+++++++++++++++++++++++++++++++++
        protected void btnDeleteRelatedProject_Click(object sender, EventArgs e)
        {
            ModalPopupListProject.Hide();
            var activity = _db.Activities.First(a => a.ActivityId == _currentActivityId);
            var projectRelated = _db.Projects.FirstOrDefault(p => p.ProjectId == activity.ProjectId);
            projectRelated.Activities.Remove(activity);
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

        protected void grdRelatedProject_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            var grdRelatedProject = (GridView)sender;

            for (int i = 0; i < grdRelatedProject.Rows.Count; i++)
            {
                int projectId = (int)grdRelatedProject.DataKeys[i].Value;
                var db = new UserOperationsContext();

                Label lblContentRelatedProject = (Label)grdRelatedProject.Rows[i].FindControl("lblContentRelatedProject");
                string projectDescription = db.Projects.FirstOrDefault(p => p.ProjectId == projectId).Description;
                var textToSee = projectDescription.Length >= 65 ? projectDescription.Substring(0, 65) + "..." : projectDescription;
                lblContentRelatedProject.Text = textToSee;
            }
        }

        protected void OpenedProjectList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            for (int i = 0; i < OpenedProjectList.Rows.Count; i++)
            {
                int projectId = (int)OpenedProjectList.DataKeys[i].Value;
                var db = new UserOperationsContext();

                Label lblContentOpenProjects = (Label)OpenedProjectList.Rows[i].FindControl("lblContentOpenProjects");
                string projectDescription = db.Projects.FirstOrDefault(p => p.ProjectId == projectId).Description;
                var textToSee = projectDescription.Length >= 65 ? projectDescription.Substring(0, 65) + "..." : projectDescription;
                lblContentOpenProjects.Text = textToSee;
            }
        }
      

        //Devono essere gestiti i vincoli per la modifica : amministratore/utente normale/creatore dell'attività
    }
}