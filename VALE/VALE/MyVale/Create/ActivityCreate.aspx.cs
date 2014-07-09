﻿using System;
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
                    Session["callingProjectId"] = Request.QueryString["ProjectId"];
                else
                    Session["callingProjectId"] = null;

                if (Request.QueryString["From"] != null) 
                {
                    Session["requestFrom"] = Request.QueryString["From"];
                    Session["statusRequested"] = Request.QueryString["Status"];
                }
                if (Session["requestFrom"] != null)
                {
                    ToBePlannedStatusButton.Visible = false;
                    switch (Session["statusRequested"].ToString())
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

                if (Session["callingProjectId"] != null)
                {
                    var db = new UserOperationsContext();
                    var projectId = Convert.ToInt32(Session["callingProjectId"].ToString());
                    var projectName = db.Projects.First(p => p.ProjectId == projectId).ProjectName;
                    SelectProject.DisableControl(projectName);
                }
                calendarTo.StartDate = calendarFrom.StartDate.Value;
                ChangeCalendars();
            } 
        }

        protected void btnSaveActivity_Click(object sender, EventArgs e)
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

                var newActivity = new Activity
                {
                    ActivityName = txtName.Text,
                    Description = txtDescription.Text,
                    Status = status,
                    CreationDate = DateTime.Today,
                    StartDate = startDate,
                    ExpireDate = expireDate,
                    RelatedProject = project,
                    PendingUsers = new List<UserData>(),
                    CreatorUserName = User.Identity.GetUserName()
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

                string returnUrl = "";

                if (Session["callingProjectId"] != null)
                    returnUrl = "/MyVale/ProjectDetails?projectId=" + Session["callingProjectId"].ToString();
                else if (Session["requestFrom"] != null)
                    returnUrl = Session["requestFrom"].ToString();
                else
                    returnUrl = "/MyVale/Activities";


                Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + newActivity.ActivityId + "&dataType=activity&returnUrl=" + returnUrl);
            }
        }



        protected void txtStartDate_TextChanged(object sender, EventArgs e)
        {
            //DateTime startDate;
            //if (DateTime.TryParse(txtStartDate.Text, out startDate))
            //    calendarTo.StartDate = startDate.AddDays(1);

            ChangeCalendars();
        }

        private void ChangeCalendars()
        {
            //txtStartDate.Text = "";

            if (txtStartDate.Text != "" && CheckDate())
            {
                txtEndDate.Enabled = true;
                calendarTo.StartDate = Convert.ToDateTime(txtStartDate.Text).AddDays(1);
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
        }

        protected void OngoingStatus_Click(object sender, EventArgs e)
        {
            ToBePlannedStatusButton.Visible = false;
            OngoingStatusButton.Visible = true;
            SuspendedStatusButton.Visible = false;
            DoneStatusButton.Visible = false;
            LabelActivityStatus.Text = "Ongoing";
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
    }
}