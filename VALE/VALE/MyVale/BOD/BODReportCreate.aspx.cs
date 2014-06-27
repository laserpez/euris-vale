using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using VALE.Logic;

namespace VALE.MyVale.BOD
{
    public partial class BODReportCreate : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            FileUploader.DataActions = new BODReportActions();
            if (!IsPostBack)
            {
                ViewState["reportId"] = 0;
                CalendarMeetingDate.StartDate = DateTime.Now;
                CalendarPublishDate.StartDate = DateTime.Now;
            }
            FileUploader.DataId = Convert.ToInt32(ViewState["reportId"]);
        }
        
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var report = new BODReport
            {
                Name = txtReportName.Text, 
                MeetingDate = Convert.ToDateTime(txtMeetingDate.Text), 
                PublishingDate = Convert.ToDateTime(txtPublishDate.Text),
                Location = txtLocation.Text,
                Text= txtReportText.Text
            };
            db.BODReports.Add(report);
            db.SaveChanges();
            ViewState["reportId"] = report.BODReportId;
            ShowFileUploader();
            
        }

        private void ShowFileUploader()
        {
            lblUploadFile.Visible = true;
            FileUploader.Visible = true;
            FileUploader.DataId = Convert.ToInt32(ViewState["reportId"]);
            
        }

        protected void txtMeetingDate_TextChanged(object sender, EventArgs e)
        {
            CalendarPublishDate.StartDate = Convert.ToDateTime(txtMeetingDate.Text).AddDays(1);
        }

    }
}