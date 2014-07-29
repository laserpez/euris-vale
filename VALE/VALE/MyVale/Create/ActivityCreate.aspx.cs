using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class ActivityCreate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                if (Request.QueryString["ProjectId"] != null)
                    Session["ActivityCreateCallingProjectId"] = Request.QueryString["ProjectId"];

                if (Request.QueryString["From"] != null)
                    Session["ActivityCreateRequestFrom"] = Request.QueryString["From"];
                   
                if (Request.QueryString["Status"] != null)
                    Session["ActivityCreateStatusRequested"] = Request.QueryString["Status"];
                
                if (Session["ActivityCreateStatusRequested"] != null)
                {
                    ToBePlannedStatusButton.Visible = false;
                    switch (Session["ActivityCreateStatusRequested"].ToString())
                    {
                        case "ToBePlannedStatus":
                            ToBePlannedStatusButtonDisabled.Visible = true;
                            LabelActivityStatus.Text = "ToBePlanned";
                            break;
                        case "OngoingStatus":
                            OngoingStatusButtonDisabled.Visible = true;
                            LabelActivityStatus.Text = "Ongoing";
                            break;
                        case "SuspendedStatus":
                            SuspendedStatusButtonDisabled.Visible = true;
                            LabelActivityStatus.Text = "Suspended";
                            break;
                        case "DoneStatus":
                            DoneStatusButtonDisabled.Visible = true;
                            LabelActivityStatus.Text = "Done";
                            break;
                        default:
                            break;
                    }
                }

                if (Session["ActivityCreateCallingProjectId"] != null)
                {
                    var db = new UserOperationsContext();
                    var projectId = Convert.ToInt32(Session["ActivityCreateCallingProjectId"].ToString());
                    var projectName = db.Projects.First(p => p.ProjectId == projectId).ProjectName;
                    SelectProject.DisableControl(projectName);
                }
                
                ChangeCalendars();
            } 
        }

        public List<ActivityType> GetTypes()
        {
            var db = new UserOperationsContext();
            return db.ActivityTypes.ToList();
        }

        private int SaveActivity() 
        {
            var db = new UserOperationsContext();
            var project = db.Projects.FirstOrDefault(p => p.ProjectName == SelectProject.ProjectNameTextBox.Text);
            if (SelectProject.ProjectNameTextBox.Text != "" && project == null)
            {
                ModelState.AddModelError("", "Nome Progetto errato");
            }
            else
            {
                DateTime? expireDate = null;
                if (!String.IsNullOrEmpty(txtEndDate.Text))
                    expireDate = Convert.ToDateTime(txtEndDate.Text);

                DateTime? startDate = null;
                if (!String.IsNullOrEmpty(txtStartDate.Text))
                    startDate = Convert.ToDateTime(txtStartDate.Text);

                ActivityStatus status;
                switch (LabelActivityStatus.Text)
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
                int budget = 0;
                int.TryParse(txtBudget.Text, out budget);
                var newActivity = new Activity
                {
                    ActivityName = txtName.Text,
                    Description = txtDescription.Text,
                    Status = status,
                    CreationDate = DateTime.Today,
                    StartDate = startDate,
                    ExpireDate = expireDate,
                    Budget = budget,
                    RelatedProject = project,
                    PendingUsers = new List<UserData>(),
                    CreatorUserName = User.Identity.GetUserName(),
                    Type = ddlSelectType.SelectedValue,
                };
                var activityActions = new ActivityActions();
                activityActions.SaveData(newActivity, db);
                db.Reports.Add(new ActivityReport
                {
                    ActivityId = newActivity.ActivityId,
                    WorkerUserName = User.Identity.GetUserName(),
                    HoursWorked = 0,
                    ActivityDescription = "Creazione attività",
                    Date = DateTime.Today

                });

                db.SaveChanges();
                return newActivity.ActivityId;
            }
            return 0;
        }

        protected void btnSaveActivity_Click(object sender, EventArgs e)
        {
            var newActivityId = SaveActivity();
            if (newActivityId != 0) 
            {
                string returnUrl = "";
                if (Session["ActivityCreateCallingProjectId"] != null)
                    returnUrl = "/MyVale/ProjectDetails?projectId=" + Session["ActivityCreateCallingProjectId"].ToString();
                else if (Session["ActivityCreateRequestFrom"] != null)
                    returnUrl = Session["ActivityCreateRequestFrom"].ToString();
                else
                    returnUrl = "/MyVale/Activities";
                Session["ActivityCreateCallingProjectId"] = null;
                Session["ActivityCreateRequestFrom"] = null;
                Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + newActivityId + "&dataType=activity&returnUrl=" + returnUrl);
            }
                
        }

        protected void btnSaveActivityAndSelectUsers_Click(object sender, EventArgs e)
        {
            var newActivityId = SaveActivity();
            if (newActivityId != 0) 
            {
                string returnUrl = "";
                if (Session["ActivityCreateCallingProjectId"] != null)
                    returnUrl = "/MyVale/ProjectDetails?projectId=" + Session["ActivityCreateCallingProjectId"].ToString();
                else if (Session["ActivityCreateRequestFrom"] != null)
                    returnUrl = Session["ActivityCreateRequestFrom"].ToString();
                else
                    returnUrl = "/MyVale/Activities";
                Session["ActivityCreateCallingProjectId"] = null;
                Session["ActivityCreateRequestFrom"] = null;
                Response.Redirect(returnUrl);
            }
        }

        protected void txtStartDate_TextChanged(object sender, EventArgs e)
        {
            DateTime dData;
            if (DateTime.TryParse(txtStartDate.Text, out dData))
                ChangeCalendars();
        }

        private void ChangeCalendars()
        {
            //txtStartDate.Text = "";

            if (txtStartDate.Text != "" && CheckDate())
            {
                txtEndDate.Enabled = true;
                calendarTo.StartDate = Convert.ToDateTime(txtStartDate.Text);
            }
            if (txtStartDate.Text == "")
            {
                txtEndDate.Text = "";
                txtEndDate.Enabled = false;
            }
        }

        private bool CheckDate()
        {
            if (!String.IsNullOrEmpty(txtEndDate.Text))
            {
                var startDate = Convert.ToDateTime(txtStartDate.Text);
                var endDate = Convert.ToDateTime(txtEndDate.Text);
                if (startDate > endDate)
                {
                    txtEndDate.Text = "";
                    calendarTo.StartDate = Convert.ToDateTime(txtStartDate.Text);
                    //txtToDateLabel.Text = "La data di fine deve essere maggiore o uguale della data d'inizio.";
                    return false;
                }
            }
            return true;
        }

        protected void ToBePlannedStatus_Click(object sender, EventArgs e)
        {
            ToBePlannedStatusButton.Visible = true;
            OngoingStatusButton.Visible = false;
            SuspendedStatusButton.Visible = false;
            DoneStatusButton.Visible = false;
            LabelActivityStatus.Text = "ToBePlanned";
            validStartDate.Enabled = false;
            lblStartDate.Text = "Data inizio";
            txtStartDate.Text = "";
        }

        protected void OngoingStatus_Click(object sender, EventArgs e)
        {
            ToBePlannedStatusButton.Visible = false;
            OngoingStatusButton.Visible = true;
            SuspendedStatusButton.Visible = false;
            DoneStatusButton.Visible = false;
            LabelActivityStatus.Text = "Ongoing";
            validStartDate.Enabled = true;
            lblStartDate.Text = "Data inizio *";
            txtStartDate.Text = DateTime.Now.ToShortDateString();
            txtStartDate_TextChanged(null, null);
        }

        protected void SuspendedStatus_Click(object sender, EventArgs e)
        {
            ToBePlannedStatusButton.Visible = false;
            OngoingStatusButton.Visible = false;
            SuspendedStatusButton.Visible = true;
            DoneStatusButton.Visible = false;
            LabelActivityStatus.Text = "Suspended";
        }

        protected void DoneStatus_Click(object sender, EventArgs e)
        {
            ToBePlannedStatusButton.Visible = false;
            OngoingStatusButton.Visible = false;
            SuspendedStatusButton.Visible = false;
            DoneStatusButton.Visible = true;
            LabelActivityStatus.Text = "Done";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            string returnUrl = "";
            if (Session["ActivityCreateCallingProjectId"] != null)
                returnUrl = "/MyVale/ProjectDetails?projectId=" + Session["ActivityCreateCallingProjectId"].ToString();
            else if (Session["ActivityCreateRequestFrom"] != null)
                returnUrl = Session["ActivityCreateRequestFrom"].ToString();
            else
                returnUrl = "/MyVale/Activities";
            Session["ActivityCreateCallingProjectId"] = null;
            Session["ActivityCreateRequestFrom"] = null;
            Response.Redirect(returnUrl);
        }
    }
}